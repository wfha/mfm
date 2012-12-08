class CouponsController < ApplicationController
  # GET /coupons
  # GET /coupons.json
  def index
    @store = Store.find(params[:store_id])
    @coupons = @store.coupons

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.create(params[:coupon])

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to store_coupons_url(@store), notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to store_coupons_url(@store), notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @coupon = @store.coupons.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to store_coupons_url(@store) }
      format.json { head :no_content }
    end
  end
end
