class HomeController < ApplicationController

  before_filter :yelp_client, :only => [:store_reviews, :load_store_reviews]
  before_filter :new_ticket

  def index

  end

  def stores
    @stores = Store.includes(:address).where("id > 1")
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
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }) #.select("distinct(dishes.id)")
    @still_open = @store.still_open?
  end

  def store_good
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }) #.select("distinct(dishes.id)")
    @still_open = @store.still_open?
  end

  def store_menu
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @still_open = @store.still_open?
  end

  def store_info
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @still_open = @store.still_open?
  end

  def store_reviews
    @store = Store.find(params[:id])
    @cart = current_cart(@store.id)
    @still_open = @store.still_open?

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

  def load_store_reviews
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
