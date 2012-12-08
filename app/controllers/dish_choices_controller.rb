class DishChoicesController < ApplicationController
  # GET /dish_choices
  # GET /dish_choices.json
  def index
    @dish_choices = DishChoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dish_choices }
    end
  end

  # GET /dish_choices/1
  # GET /dish_choices/1.json
  def show
    @dish_choice = DishChoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish_choice }
    end
  end

  # GET /dish_choices/new
  # GET /dish_choices/new.json
  def new
    @dish_choice = DishChoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish_choice }
    end
  end

  # GET /dish_choices/1/edit
  def edit
    @dish_choice = DishChoice.find(params[:id])
  end

  # POST /dish_choices
  # POST /dish_choices.json
  def create
    @dish_choice = DishChoice.new(params[:dish_choice])

    respond_to do |format|
      if @dish_choice.save
        format.html { redirect_to @dish_choice, notice: 'Dish choice was successfully created.' }
        format.json { render json: @dish_choice, status: :created, location: @dish_choice }
      else
        format.html { render action: "new" }
        format.json { render json: @dish_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dish_choices/1
  # PUT /dish_choices/1.json
  def update
    @dish_choice = DishChoice.find(params[:id])

    respond_to do |format|
      if @dish_choice.update_attributes(params[:dish_choice])
        format.html { redirect_to @dish_choice, notice: 'Dish choice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dish_choices/1
  # DELETE /dish_choices/1.json
  def destroy
    @dish_choice = DishChoice.find(params[:id])
    @dish_choice.destroy

    respond_to do |format|
      format.html { redirect_to dish_choices_url }
      format.json { head :no_content }
    end
  end
end
