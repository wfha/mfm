class PlansController < ApplicationController
  # GET /plans
  # GET /plans.json
  def index
    @store = Store.find(params[:store_id])
    @plans = @store.plans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @store = Store.find(params[:store_id])
    @plan = @store.plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @store = Store.find(params[:store_id])
    @plan = @store.plans.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @store = Store.find(params[:store_id])
    @plan = @store.plans.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @store = Store.find(params[:store_id])
    @plan = @store.plans.create(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { redirect_to store_plans_url(@store), notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @store = Store.find(params[:store_id])
    @plan = @store.plans.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to store_plans_url(@store), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @store = Store.find(params[:store_id])
    @plan = @store.plans.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to store_plans_url(@store) }
      format.json { head :no_content }
    end
  end
end
