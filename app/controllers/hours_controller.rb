class HoursController < ApplicationController
  # GET /hours
  # GET /hours.json
  def index
    @store = Store.find(params[:store_id])
    @hours = @store.hours

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hours }
    end
  end

  # GET /hours/1
  # GET /hours/1.json
  def show
    @store = Store.find(params[:store_id])
    @hour = @store.hours.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hour }
    end
  end

  # GET /hours/new
  # GET /hours/new.json
  def new
    @store = Store.find(params[:store_id])
    @hour = @store.hours.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hour }
    end
  end

  # GET /hours/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @hour = @store.hours.find(params[:id])
  end

  # POST /hours
  # POST /hours.json
  def create
    @store = Store.find(params[:store_id])
    @hour = @store.hours.create(params[:hour])

    respond_to do |format|
      if @hour.save
        format.html { redirect_to store_hours_url(@store), notice: 'Hour was successfully created.' }
        format.json { render json: @hour, status: :created, location: @hour }
      else
        format.html { render action: "new" }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hours/1
  # PUT /hours/1.json
  def update
    @store = Store.find(params[:store_id])
    @hour = @store.hours.find(params[:id])

    respond_to do |format|
      if @hour.update_attributes(params[:hour])
        format.html { redirect_to store_hours_url(@store), notice: 'Hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hours/1
  # DELETE /hours/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @hour = @store.hours.find(params[:id])
    @hour.destroy

    respond_to do |format|
      format.html { redirect_to store_hours_url(@store) }
      format.json { head :no_content }
    end
  end
end
