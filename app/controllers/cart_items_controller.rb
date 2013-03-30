class CartItemsController < ApplicationController

  # Authenticate and load @cart_item for the whole controller
  load_and_authorize_resource

  # GET /cart_items
  # GET /cart_items.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cart_items }
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart_item }
    end
  end

  # GET /cart_items/new
  # GET /cart_items/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart_item }
    end
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    store_id = params[:store_id].to_i
    @cart = current_cart(store_id)

    if params[:dish_id]
      dish = Dish.find(params[:dish_id])
      note = params[:note]
      price_adjustment = params[:price_adjustment].to_d
      quantity = params[:quantity].to_i

      @cart_item = @cart.add_dish(dish, dish.name, dish.price + price_adjustment, quantity, note)
    elsif params[:coupon_id]
      begin
        coupon = Coupon.find(Coupon.decode_coupon params[:coupon_id])
        quantity = 1

        if @cart.total_price >= coupon.minimum                       # Validate coupon minimum
          if coupon.store.id == store_id                             # Validate coupon store
            if Time.now.between?(coupon.start_at, coupon.end_at)     # Validate coupon expiration
              if coupon.still_open?                                  # Validate coupon time
                @cart_item = @cart.add_coupon(coupon, coupon.name, coupon.price, quantity)
                @message = "Coupon applied"
              else
                @message = "Not right time"
              end
            else
              @message = "Expired coupon"
            end
          else
            @message = "Not this store"
          end
        else
          @message = "Not reach minimum"
        end

      rescue StandardError => bang
        @message = "Invalid coupon"
        return
      end
    end

    respond_to do |format|
      if @cart_item
        if @cart_item.save
          format.js   { @current_item = @cart_item }
          format.mjs  { @current_item = @cart_item }
          format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
          format.json { render json: @cart_item, status: :created, location: @cart_item }
        else
          format.js   { @current_item = @cart_item }
          format.mjs  { @current_item = @cart_item }
          format.html { render action: "new" }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      else
        format.js   {}
        format.mjs  {}
      end
    end
  end

  # PUT /cart_items/1
  # PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update_attributes(params[:cart_item])
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    @cart = @cart_item.cart
    @cart.update_coupons

    respond_to do |format|
      format.html { redirect_to cart_items_url }
      format.json { head :no_content }
      format.js
      format.mjs
    end
  end
end
