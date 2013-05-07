class AdminController < ApplicationController
  def index
    redirect_to stores_url
  end

  def users
    @users = User.where("email NOT LIKE :prefix", prefix: "guest_%")

  end

  def orders
    if params[:date]
      @date = Date.parse params[:date]
    else
      @date = Date.today
    end

    st = @date.beginning_of_day
    en = @date.end_of_day

    @g_orders = Order.where("store_id = 1 AND created_at >= :st AND created_at <= :en", {:st => st, :en => en})
    @r_orders = Order.where("store_id > 1 AND created_at >= :st AND created_at <= :en", {:st => st, :en => en})
    @tickets = Ticket.where("created_at >= :st AND created_at <= :en", {:st => st, :en => en})
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

  def handle_ticket
    @ticket = Ticket.find(params[:id])
    if params[:handled] == "true"
      @ticket.handled = true
    else
      @ticket.handled = false
    end
    @ticket.save

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

  def create_transaction
    # Get redeem amount and user from params
    amount = params[:amount].to_f
    @user_id = params[:user_id].to_i

    # Create the transaction
    Transaction.create(name: "From Admin", user_id: @user_id, amount: amount)

    # After transaction, get the new cash back amount
    @cash_back = User.find(@user_id).cash_back

    respond_to do |format|
      format.js
      format.mjs
    end
  end

  def create_redeem
    # Get redeem amount and user from params
    amount = params[:amount].to_f
    user_id = params[:user_id].to_i
    user = User.find(user_id)

    # The result of create_redeem, default to false
    @result = false

    # Make sure user has enought cash back to redeem
    if amount < user.cash_back && amount > 0
      # Create the transaction for this redeem
      @tran = Transaction.create(name: "From Redeem", user_id: user_id, amount: -amount)

      # Notify with a ticket
      Ticket.create(email: user.email, content: "Feng Wan is requesting a redeem of $10.00. <br/>Address: 200 Charles Haltom Ave. Apt. 10B<br/>College Station, TX")

      # After redeem, refresh user object and get new cash back amount
      user.reload
      @cash_back = user.cash_back

      # The result of create_redeem
      @result = true
    end

    respond_to do |format|
      format.js
      format.mjs
    end
  end
end
