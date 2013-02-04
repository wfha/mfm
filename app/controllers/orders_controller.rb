class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_cart(params[:store_id])
    if @cart.delivery_type == 'delivery' && @cart.total_price < @cart.store.delivery_minimum
      redirect_to home_stores_url, notice: "The order doesn't meet minimum!"
      return
    end

    if user_signed_in?
      current_user.build_address if @cart.delivery_type == 'delivery' && current_user.address.nil?
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => current_user)
    else
      user = User.new
      user.build_address if @cart.delivery_type == 'delivery'
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => user)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    p = params[:order]

    if user_signed_in?
      @user = User.find(p[:user_attributes][:id])
      @user.update_attributes!(p[:user_attributes])
      p.delete(:user_attributes)
      @order = Order.new(p)
      @order.user = @user
    else
      @order = Order.new(p)
    end

    if @order.user.email.blank? && @order.user.password.blank? && @order.user.password_confirmation.blank?
      @order.user.email = "guest_#{Time.now.to_i}#{rand(99)}@meals4.me"
      @order.user.password = "guest_password"
      @order.user.password_confirmation = "guest_password"
    end

    respond_to do |format|
      if @order.save
        new_cart(@order.store_id)

        if @order.payment_type == 'paypal'
          format.html { redirect_to @order.paypal_url(home_stores_url, paypal_notifications_url) }
        else
          Order.delay.to_fax(@order.id, p[:card_number], p[:card_verification], p[:card_expires_on])
          Order.delay(run_at: 5.minutes.from_now).to_phone(@order.id)

          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.mobile { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render json: @order, status: :created, location: @order }
        end
      else
        @cart = current_cart(@order.store_id)
        @order.user.email = ""

        format.html { render action: "new" }
        format.mobile { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
