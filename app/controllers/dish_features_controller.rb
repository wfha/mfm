class DishFeaturesController < ApplicationController
  # GET /dish_features
  # GET /dish_features.json
  def index
    @dish_features = DishFeature.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dish_features }
    end
  end

  # GET /dish_features/1
  # GET /dish_features/1.json
  def show
    @dish_feature = DishFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish_feature }
    end
  end

  # GET /dish_features/new
  # GET /dish_features/new.json
  def new
    @dish_feature = DishFeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish_feature }
    end
  end

  # GET /dish_features/1/edit
  def edit
    @dish_feature = DishFeature.find(params[:id])
  end

  # POST /dish_features
  # POST /dish_features.json
  def create
    @dish_feature = DishFeature.new(params[:dish_feature])

    respond_to do |format|
      if @dish_feature.save
        format.html { redirect_to @dish_feature, notice: 'Dish feature was successfully created.' }
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
    @dish_feature = DishFeature.find(params[:id])

    respond_to do |format|
      if @dish_feature.update_attributes(params[:dish_feature])
        format.html { redirect_to @dish_feature, notice: 'Dish feature was successfully updated.' }
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
    @dish_feature = DishFeature.find(params[:id])
    @dish_feature.destroy

    respond_to do |format|
      format.html { redirect_to dish_features_url }
      format.json { head :no_content }
    end
  end
end
