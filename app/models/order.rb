class Order < ActiveRecord::Base
  # In order to use number_to_currency
  include ActionView::Helpers::NumberHelper

  attr_accessible :invoice, :note, :payment_type, :tip, :transaction_id,
                  :user, :user_attributes, :cart, :cart_id, :store, :store_id,
                  :card_type, :card_number, :card_verification, :card_expires_on, :tip_rate

  attr_accessor :card_type, :card_number, :card_verification, :card_expires_on, :tip_rate

  # fix the virtual attribute :card_expires_on bug
  columns_hash["card_expires_on"] = ActiveRecord::ConnectionAdapters::Column.new("card_expires_on", nil, "date")

  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  PAYMENT_TYPES = [['Cash ', 'cash'], ['CreditCard ', 'credit_card'], ['PayPal ', 'paypal']]
  CREDIT_CARD_TYPES = [["Visa", "visa"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"]]
  TIP_RATES = [['Tip w/ cash', 0], ['Tip 5%', 0.05], ['Tip 10%', 0.1], ['Tip 15%', 0.15], ['Tip 20%', 0.2], ['Tip 25%', 0.25], ['Tip 30%', 0.3]]


  def paypal_url(return_url, notify_url)
    values = {
        :business => APP_CONFIG['paypal_email'],
        :cancel_return => '/orders/cancel',
        :charset => 'utf-8',
        :cmd => '_cart',
        :currency_code => 'USD',
        :custom => '',
        :image_url => "http://secure.killervideostore.com/kvs-logo.png",
        :invoice => id,
        :lc => 'US',
        :no_shipping => 0,
        :no_note => 1,
        :notify_url => notify_url,
        :num_cart_items => cart.cart_items.size,
        :return => return_url,
        :rm => 2,
        :secret => 'hello_token',
        :tax_cart => number_with_precision(cart.tax, :precision => 2),
        :upload => 1,
    }

    cart.cart_items.each_with_index do |item, index|
      values.merge!({
                        "amount_#{index+1}" => item.price,
                        "discount_rate_#{index+1}" => 0,
                        "item_name_#{index+1}" => item.name,
                        "item_number_#{index+1}" => item.id,
                        "quantity_#{index+1}" => item.quantity,
                        "shipping_#{index+1}" => 0
                    })
    end

    cart_size = cart.cart_items.size
    values.merge!({
                      "amount_#{cart_size+1}" => cart.delivery_fee,
                      "discount_rate_#{cart_size+1}" => 0,
                      "item_name_#{cart_size+1}" => 'Delivery fee',
                      "item_number_#{cart_size+1}" => '',
                      "quantity_#{cart_size+1}" => 1,
                      "shipping_#{cart_size+1}" => 0,

                      "amount_#{cart_size+2}" => tip,
                      "discount_rate_#{cart_size+2}" => 0,
                      "item_name_#{cart_size+2}" => 'Tip',
                      "item_number_#{cart_size+2}" => '',
                      "quantity_#{cart_size+2}" => 1,
                      "shipping_#{cart_size+2}" => 0
                  })

    APP_CONFIG['paypal_base_url'] + "?" + values.to_query
  end
end
