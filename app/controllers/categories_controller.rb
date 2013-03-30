class CategoriesController < ApplicationController

  # Authenticate @category for the whole controller
  authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @menu = Menu.find(params[:menu_id])
    @categories = @menu.categories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.create(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to store_menus_url(@menu.store), notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to store_menus_url(@menu.store), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @menu = Menu.find(params[:menu_id])
    @category = @menu.categories.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to store_menus_url(@menu.store) }
      format.json { head :no_content }
    end
  end
end
