class PaypalNotification < ActiveRecord::Base
  attr_accessible :create, :params, :status, :transaction_id
  belongs_to :order
  serialize :params

  after_create :mark_order_as_paid

  private

  def mark_order_as_paid
    if status == 'Completed' && params[:secret] == 'hello_token' &&
        params[:receiver_email]  == APP_CONFIG['paypal_email'] &&
        params[:mc_gross] == order.cart.total_price && params[:mc_currency] == 'USD'
      order.update_attributes(:payment_status => 'paid', :updated_at => Time.now)
    end
  end
end
