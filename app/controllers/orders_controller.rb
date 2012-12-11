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
    @cart = current_cart
    if @cart.cart_items.empty?
      redirect_to home_stores_url, notice: "Your cart is empty!"
      return
    end

    if user_signed_in?
      current_user.address = Address.new unless current_user.address
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => current_user)
    else
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => User.new(:address => Address.new))
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
      @user.save!
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
    @order.user.save

    respond_to do |format|
      if @order.save
        new_cart
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
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
