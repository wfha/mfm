class HomeController < ApplicationController

  before_filter :yelp_client, :only => [:store_review, :load_store_review]
  before_filter :new_ticket

  def index

  end

  def google
    @info = "This is a google for restaurants"

  end

  def stores
    @stores = Store.includes(:address).where("rank > 0").order("rank")
    @addresses = []
    @stores.each { |store| @addresses << store.address }

    if @addresses
      @json = @addresses.to_gmaps4rails
    end
  end

  def grocery
    @store = Store.first
    @cart = current_cart(@store.id)
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }).order("rank") #.select("distinct(dishes.id)")
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def store_overview
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?

    @gallery = @store.gallery
    @photos = @gallery.gallery_photos if @gallery
  end

  def store_info
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def store_good
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }).order("rank") #.select("distinct(dishes.id)")
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def store_menu
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def store_promo
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def store_review
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?

    request = Yelp::Phone::Request::Number.new(phone_number: @store.phone, yws_id: '00CRzCP7C-1GMSGy3su_Ig')
    response = @client.search(request)
    @reviews = response["businesses"]
  end

  def load_store_good
    @store = Store.find(params[:id])
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }) #.select("distinct(dishes.id)")

    respond_to do |format|
      format.js
    end
  end

  def load_store_info
    @store = Store.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def load_store_review
    @store = Store.find(params[:id])

    request = Yelp::Phone::Request::Number.new(phone_number: @store.phone, yws_id: '00CRzCP7C-1GMSGy3su_Ig')
    response = @client.search(request)
    @reviews = response["businesses"]

    respond_to do |format|
      format.js
    end
  end

  def plans
    @plans = Plan.all
  end

  def coupons
    @coupons = Coupon.all
  end

  def print_coupon
    @coupon = Coupon.find(params[:id])

    render :layout => false
  end

  # The Paypal IPN Notify Page
  # ======================================================

  protect_from_forgery :except => [:paypal_notify]

  include ActiveMerchant::Billing::Integrations

  def paypal_notify
    ActiveMerchant::Billing::Base.mode = :test
    notify = Paypal::Notification.new(request.raw_post)
    order = Order.find(notify.invoice)
    if notify.acknowledge
      begin
        amount_in_db = Money.new ((order.cart.total_price+order.tip)*100).round
        if notify.complete? and amount_in_db == notify.amount
          order.payment_status = 'paid'
          order.updated_at = Time.now

          Order.delay.to_fax(order.id)
          Order.delay(run_at: 5.minutes.from_now).to_phone(order.id)
        else
          logger.error("Failed to verify Paypal's notification, please investigate")
        end
      rescue => e
        order.payment_status = 'pending'
        raise
      ensure
        order.save
      end
    end

    render :nothing => true
  end

  def paypal_cancel

  end

  # Twilio Phone Instructions
  # ======================================================
  def reminder
    @order_id = params[:order_id]
    @post_to = "https://" + APP_CONFIG['domain'] + "/home/directions?order_id=#{@order_id}"
    render :action => "reminder.xml.builder", :layout => false
  end

  def directions
    @order_id = params[:order_id]

    if !params['Digits'] or params['Digits'] != '1' or params['Digits'] != '2'
      redirect_to :action => 'reminder', :order_id => @order_id
      return
    elsif params['Digits'] == '1'
      @order = Order.find(@order_id)
      @order.handled = true
      @order.save
    elsif params['Digits'] == '2'

    end

    @redirect_to = "https://" + APP_CONFIG['domain'] + '/home/reminder'
    render :action => "directions.xml.builder", :layout => false
  end

  def test_twilio
    Order.to_phone(1)
    render :nothing => true
  end

  # Admin Console
  # ======================================================

  def orders
    ds = Date.today.beginning_of_day
    @r_orders = Order.where("store_id = 1 AND created_at >= :time", {:time => ds})
    @g_orders = Order.where("store_id > 1 AND created_at >= :time", {:time => ds})
  end

  def handle_order
    @order = Order.find(params[:id])
    if params[:handled] == "true"
      @order.handled = true
    else
      @order.handled = false
    end
    @order.save

    respond_to do |format|
      format.js
      format.mjs
    end
  end

  def order_modal
    @order = Order.find(params[:id])

    respond_to do |format|
      format.js
      format.mjs
    end
  end

  def my_orders
    if current_user.nil?
      redirect_to home_index_path
    end
  end

  # Load the dish choices
  # ======================================================

  def dish_modal
    @dish = Dish.find(params[:id])
    @still_open = @dish.category.menu.store.still_open? && @dish.category.menu.still_open?

    respond_to do |format|
      format.js
      format.mjs
    end
  end

  private
  def yelp_client
    @client = Yelp::Client.new
  end

  def new_ticket
    @ticket = Ticket.new
  end
end
