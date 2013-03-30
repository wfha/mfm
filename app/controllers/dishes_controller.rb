class DishesController < ApplicationController

  # Authenticate @dish for the whole controller
  authorize_resource

  # GET /dishes
  # GET /dishes.json
  def index
    @category = Category.find(params[:category_id])
    @dishes = @category.dishes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dishes }
    end
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/new
  # GET /dishes/new.json
  def new
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/1/edit
  def edit
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.find(params[:id])
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.create(params[:dish])

    respond_to do |format|
      if @dish.save
        format.html { redirect_to store_menus_url(@category.menu.store), notice: 'Dish was successfully created.' }
        format.json { render json: @dish, status: :created, location: @dish }
      else
        format.html { render action: "new" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dishes/1
  # PUT /dishes/1.json
  def update
    params[:dish][:dish_feature_ids] ||= []
    params[:dish][:dish_choice_ids] ||= []
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.find(params[:id])

    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        format.html { redirect_to store_menus_url(@category.menu.store), notice: 'Dish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @category = Category.find(params[:category_id])
    @dish = @category.dishes.find(params[:id])
    @dish.destroy

    respond_to do |format|
      format.html { redirect_to store_menus_url(@category.menu.store) }
      format.json { head :no_content }
    end
  end
end
