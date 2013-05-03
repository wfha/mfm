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
    amount = params[:amount].to_f
    user_id = params[:user_id].to_i
    Transaction.create(name: "From Admin", user_id: user_id, amount: amount)

    respond_to do |format|
      format.js
      format.mjs
    end
  end
end
