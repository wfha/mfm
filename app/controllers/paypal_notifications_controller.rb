class PaypalNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  # GET /paypal_notifications
  # GET /paypal_notifications.json
  def index
    @paypal_notifications = PaypalNotification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paypal_notifications }
    end
  end

  # GET /paypal_notifications/1
  # GET /paypal_notifications/1.json
  def show
    @paypal_notification = PaypalNotification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paypal_notification }
    end
  end

  # GET /paypal_notifications/new
  # GET /paypal_notifications/new.json
  def new
    @paypal_notification = PaypalNotification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paypal_notification }
    end
  end

  # GET /paypal_notifications/1/edit
  def edit
    @paypal_notification = PaypalNotification.find(params[:id])
  end

  # POST /paypal_notifications
  # POST /paypal_notifications.json
  def create
    PaypalNotification.create!(:params => params, :order_id => params[:invoice],
                               :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end

  # PUT /paypal_notifications/1
  # PUT /paypal_notifications/1.json
  def update
    @paypal_notification = PaypalNotification.find(params[:id])

    respond_to do |format|
      if @paypal_notification.update_attributes(params[:paypal_notification])
        format.html { redirect_to @paypal_notification, notice: 'Paypal notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paypal_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paypal_notifications/1
  # DELETE /paypal_notifications/1.json
  def destroy
    @paypal_notification = PaypalNotification.find(params[:id])
    @paypal_notification.destroy

    respond_to do |format|
      format.html { redirect_to paypal_notifications_url }
      format.json { head :no_content }
    end
  end
end
