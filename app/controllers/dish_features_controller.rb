class DishFeaturesController < ApplicationController

  # Authenticate @dish_feature for the whole controller
  authorize_resource

  # GET /dish_features
  # GET /dish_features.json
  def index
    @store = Store.find(params[:store_id])
    @dish_features = @store.dish_features

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dish_features }
    end
  end

  # GET /dish_features/1
  # GET /dish_features/1.json
  def show
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish_feature }
    end
  end

  # GET /dish_features/new
  # GET /dish_features/new.json
  def new
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish_feature }
    end
  end

  # GET /dish_features/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.find(params[:id])
  end

  # POST /dish_features
  # POST /dish_features.json
  def create
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.create(params[:dish_feature])

    respond_to do |format|
      if @dish_feature.save
        format.html { redirect_to store_dish_features_url(@store), notice: 'Dish feature was successfully created.' }
        format.json { render json: @dish_feature, status: :created, location: @dish_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @dish_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dish_features/1
  # PUT /dish_features/1.json
  def update
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.find(params[:id])

    respond_to do |format|
      if @dish_feature.update_attributes(params[:dish_feature])
        format.html { redirect_to store_dish_features_url(@store), notice: 'Dish feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dish_features/1
  # DELETE /dish_features/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @dish_feature = @store.dish_features.find(params[:id])
    @dish_feature.destroy

    respond_to do |format|
      format.html { redirect_to store_dish_features_url(@store) }
      format.json { head :no_content }
    end
  end
end
