class Order < ActiveRecord::Base
  # In order to use number_to_currency
  include ActionView::Helpers::NumberHelper
  extend ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers

  attr_accessible :invoice, :note, :payment_type, :payment_status, :tip, :transaction_id,
                  :user, :user_attributes, :cart, :cart_id, :store, :store_id,
                  :card_number, :card_verification, :card_expires_on

  attr_accessor :card_number, :card_verification, :card_expires_on

  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  # If using delivery, validate the address
  with_options if: :is_delivery? do |opt|
    opt.validates_with CustomValidators::Distance
  end

  # If using credit card, validate credit card
  with_options if: :pay_with_credit_card? do |opt|
    opt.validates :card_number, presence: true
    opt.validates :card_verification, presence: true, format: { with: CustomValidators::CardVerification.regex, message: CustomValidators::CardVerification.hint }
    opt.validates :card_expires_on, presence: true, format: { with: CustomValidators::CardExpiresOn.regex, message: CustomValidators::CardExpiresOn.hint }
    opt.validates_with CustomValidators::CardNumber
  end

  TIP_RATES = [['Tip cash', 0], ['Tip $1.00', 1], ['Tip $2.00', 2], ['Tip $3.00', 3], ['Tip $4.00', 4], ['Tip $5.00', 5],
               ['Tip $6.00', 6], ['Tip $7.00', 7], ['Tip $8.00', 8], ['Tip $9.00', 9], ['Tip $10.00', 10]]

  def payment_types
    if store.id.to_i == 1
      [['Cash ', 'cash'], ['PayPal ', 'paypal']]
    elsif store.payments.include?(Payment.find_by_name("paypal"))
      [['Cash ', 'cash'], ['CreditCard ', 'credit_card'], ['PayPal ', 'paypal']]
    else
      [['Cash ', 'cash'], ['CreditCard ', 'credit_card']]
    end
  end

  def pay_with_credit_card?
    payment_type == 'credit_card'
  end

  def is_delivery?
    cart.delivery_type == 'delivery'
  end

  def paypal_url
    values = {
        :business       => APP_CONFIG['paypal_email'],
        :cancel_return  => home_paypal_cancel_url(:host => APP_CONFIG['domain']),
        :charset        => 'utf-8',
        :cmd            => '_cart',
        :currency_code  => 'USD',
        :custom         => '',
        :image_url      => "https://meals4.me/assets/mfm_logo.png",
        :invoice        => id,
        :lc             => 'US',
        :no_shipping    => 0,
        :no_note        => 1,
        :notify_url     => home_paypal_notify_url(:host => APP_CONFIG['domain']),
        :num_cart_items => cart.cart_items.size,
        :return         => home_stores_url(:host => APP_CONFIG['domain']),
        :rm             => 2,
        :secret         => 'hello_token',
        :tax_cart       => number_with_precision(cart.tax, :precision => 2),
        :upload         => 1,
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

  def self.to_fax(order_id, *cc)
    @order = Order.find(order_id)

    if @order.payment_type == 'credit_card'
      @order.card_number = cc[0]
      @order.card_verification = cc[1]
      @order.card_expires_on = cc[2]
    end

    html = File.open(Rails.root.join('app/views/orders/_fax.html.erb')).read
    template = ERB.new(html)
    str = template.result(binding)
    client = Savon.client(log: false, wsdl: APP_CONFIG["interfax_url"])  # Turn off log for security

    if APP_CONFIG["mfm_mode"] == "test"
      response_interfax = client.call(:send_char_fax, :message => {'Username' => APP_CONFIG["interfax_usr"], 'Password' => APP_CONFIG["interfax_pwd"],
                                                                   'FaxNumber' => '9790000000', 'Data' => str, 'FileType' => 'HTML'})
    elsif APP_CONFIG["mfm_mode"] == "production"
      response_interfax = client.call(:send_char_fax, :message => {'Username' => APP_CONFIG["interfax_usr"], 'Password' => APP_CONFIG["interfax_pwd"],
                                                                   'FaxNumber' => @order.store.fax, 'Data' => str, 'FileType' => 'HTML'})
    end

    @order = nil # Clear credit card info
    if response_interfax.body[:send_char_fax_response][:send_char_fax_result].to_i > 0
      @order = Order.find(order_id)
      @order.handled = true
      @order.save
    else
      # Fax failed
    end
  end

  #def self.to_phone(order_id)
  #  @order = Order.find(order_id)
  #
  #  if APP_CONFIG["mfm_mode"] == "test"
  #    response_tropo = RestClient.get APP_CONFIG["tropo_url"], {params: {token: APP_CONFIG["tropo_token"], action: 'create', phone: '19797396180', order_id: '1234'}}
  #  elsif APP_CONFIG["mfm_mode"] == "production"
  #    response_tropo = RestClient.get APP_CONFIG["tropo_url"], {params: {token: APP_CONFIG["tropo_token"], action: 'create', phone: "1" + @order.store.phone, order_id: order_id}}
  #  end
  #
  #  if response_tropo.code == 200
  #    puts "Msg sent HTTP/#{response_tropo.code}"
  #  else
  #    puts "ERROR | HTTP/#{response_tropo.code}"
  #  end
  #end

  def self.to_phone(order_id)
    @order = Order.find(order_id)

    data = {
        :from => "+1" + APP_CONFIG['twilio_number'],
        :to => "+1" + @order.store.phone,
        :url => "https://" + APP_CONFIG['domain'] + "/home/reminder?order_id=#{order_id}"
        #:url => "http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient"
    }

    begin
      client = Twilio::REST::Client.new(APP_CONFIG['twilio_sid'], APP_CONFIG['twilio_token'])
      client.account.calls.create data
    rescue StandardError => bang
      return
    end
  end
end
