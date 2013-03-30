class TicketsController < ApplicationController

  # Authenticate and load @ticket for the whole controller
  load_and_authorize_resource

  # GET /tickets
  # GET /tickets.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.mobile { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.js   { }
        format.mjs  { }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.mobile { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
