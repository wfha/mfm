class DishDiscountsController < ApplicationController
  # GET /dish_discounts
  # GET /dish_discounts.json
  def index
    @store = Store.find(params[:store_id])
    @dish_discounts = @store.dish_discounts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dish_discounts }
    end
  end

  # GET /dish_discounts/1
  # GET /dish_discounts/1.json
  def show
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish_discount }
    end
  end

  # GET /dish_discounts/new
  # GET /dish_discounts/new.json
  def new
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish_discount }
    end
  end

  # GET /dish_discounts/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.find(params[:id])
  end

  # POST /dish_discounts
  # POST /dish_discounts.json
  def create
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.create(params[:dish_discount])

    respond_to do |format|
      if @dish_discount.save
        format.html { redirect_to store_dish_discounts_url(@store), notice: 'Dish discount was successfully created.' }
        format.json { render json: @dish_discount, status: :created, location: @dish_discount }
      else
        format.html { render action: "new" }
        format.json { render json: @dish_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dish_discounts/1
  # PUT /dish_discounts/1.json
  def update
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.find(params[:id])

    respond_to do |format|
      if @dish_discount.update_attributes(params[:dish_discount])
        format.html { redirect_to store_dish_discounts_url(@store), notice: 'Dish discount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dish_discounts/1
  # DELETE /dish_discounts/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @dish_discount = @store.dish_discounts.find(params[:id])
    @dish_discount.destroy

    respond_to do |format|
      format.html { redirect_to store_dish_discounts_url(@store) }
      format.json { head :no_content }
    end
  end
end
