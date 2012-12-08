class MenusController < ApplicationController
  # GET /menus
  # GET /menus.json
  def index
    @store = Store.find(params[:store_id])
    @menus = @store.menus

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @store = Store.find(params[:store_id])
    @menu = @store.menus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @store = Store.find(params[:store_id])
    @menu = @store.menus.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @menu = @store.menus.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @store = Store.find(params[:store_id])
    @menu = @store.menus.create(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to store_menus_url(@store), notice: 'Menu was successfully created.' }
        format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @store = Store.find(params[:store_id])
    @menu = @store.menus.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to store_menus_url(@store), notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @menu = @store.menus.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to store_menus_url(@store) }
      format.json { head :no_content }
    end
  end
end
