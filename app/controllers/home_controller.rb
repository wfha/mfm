class HomeController < ApplicationController

  before_filter :yelp_client, :only => [:store_review, :store_overview]
  before_filter :new_ticket
  before_filter :store_setup, :only => [:store_overview, :store_good, :store_info, :store_menu, :store_promo, :store_review]

  # Main Pages
  # ======================================================
  def index
    @ads = Advertisement.all
    @posts = Post.all
  end

  def stores
    @tags = Tag.includes(:stores).where("rank > 0").order("rank")
  end

  def delivery
    @stores = Store.includes(:address).where("rank > 0").order("rank")
    @addresses = []
    @stores.each { |store| @addresses << store.address }

    if @addresses
      @json = @addresses.to_gmaps4rails
    end
  end

  def grocery
    @store = Store.find(1)
    @cart = current_cart(@store.id, false)
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }).order("rank") #.select("distinct(dishes.id)")
    @store_still_open = @store.still_open?
    @menu_still_open = true
    @can_order_online = @store.can_order_online?
  end

  def plans
    @plans = Plan.all
  end

  def coupons
    @coupons = Coupon.includes({ :store => :address })
    @addresses = []
    @coupons.each { |coupon| @addresses << coupon.store.address }

    if @addresses
      @json = @addresses.to_gmaps4rails
    end
  end

  # All About Stores
  # ======================================================
  def store_overview
    @gallery = @store.gallery
    @photos = @gallery.gallery_photos if @gallery

    # store_review
    #=========================
    request = Yelp::Phone::Request::Number.new(phone_number: @store.phone, yws_id: APP_CONFIG['yelp_yws_id'])
    response = @client.search(request)
    @reviews = response["businesses"]

    # store_info
    #=========================
    @addresses = []
    @addresses << @store.address
    @json = @addresses.to_gmaps4rails
  end

  def store_info
    @addresses = []
    @addresses << @store.address
    @json = @addresses.to_gmaps4rails
  end

  def store_good
    @dishes = Dish.joins(:dish_features, :category => :menu)
    .where({ 'menus.store_id' => @store.id, 'dish_features.name' => 'good' }).order("rank") #.select("distinct(dishes.id)")
  end

  def store_menu
  end

  def store_promo
  end

  def store_review
    request = Yelp::Phone::Request::Number.new(phone_number: @store.phone, yws_id: APP_CONFIG['yelp_yws_id'])
    response = @client.search(request)
    @reviews = response["businesses"]
  end

  require 'open-uri'

  def print_coupon
    @coupon = Coupon.find(params[:id])

    if mobile_device?
      if Rails.env.production?
        url = @coupon.photo_url.to_s
        data = open(url).read
        send_data data, :filename=>"coupon_#{@coupon.id}.jpg", :type => 'image/jpeg', :disposition => 'attachment'
      else
        send_file Rails.public_path + @coupon.photo_url.to_s, :type => 'image/jpeg', :disposition => 'attachment'
      end
    else
      render :layout => false
    end
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

          # How to notice the paypal order
          #Order.delay.to_fax(order.id)
          #Order.delay(run_at: 3.minutes.from_now).to_phone(order.id)
          Order.delay.to_phone(order.id)
          # Create cash back for this order
          order.to_transaction
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
  def phone_start
    @order_id = params[:order_id]
    @post_to = "https://" + APP_CONFIG['domain'] + "/home/phone_end?order_id=#{@order_id}"
    render :action => "phone_start.xml.builder", :layout => false
  end

  def phone_end
    @order_id = params[:order_id]

    if !params['Digits'] || (params['Digits'] != '1' && params['Digits'] != '2')
      redirect_to :action => 'phone_start', :order_id => @order_id
      return
    elsif params['Digits'] == '1'
      @msg = "You pressed one, you got the order."
      @order = Order.find(@order_id)
      @order.status = "fax_succeeded"
      @order.handled = true
      @order.save
    elsif params['Digits'] == '2'
      @msg = "You pressed two, you did not get the order. We'll look at it."
      @order = Order.find(@order_id)
      @order.status = "fax_failed"
      @order.handled = false
      @order.save
    end

    #@redirect_to = "https://" + APP_CONFIG['domain'] + "/home/phone_start?order_id=#{@order_id}"
    render :action => "phone_end.xml.builder", :layout => false
  end

  def phone_test
    Order.to_phone(1)
    render :nothing => true
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

  def store_setup
    @store = Store.find(params[:id])
    if params[:delivery_type]
      session["cart_delivery_type_#{@store.id}"] = params[:delivery_type]
    else
      unless session["cart_delivery_type_#{@store.id}"]
        if @store.has_delivery_service?
          session["cart_delivery_type_#{@store.id}"] = 'delivery'
        elsif @store.has_melivery_service?
          session["cart_delivery_type_#{@store.id}"] = 'melivery'
        elsif @store.has_pick_up_service?
          session["cart_delivery_type_#{@store.id}"] = 'pick_up'
        elsif @store.has_express_service?
          session["cart_delivery_type_#{@store.id}"] = 'express'
        end
      end
    end
    @cart = current_cart(@store.id, false)
    @has_cart = true  # Show the cart toggle in mobile version
    @store_still_open = @store.still_open?
    @menu_still_open = true
  end

end
