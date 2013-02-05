class Order < ActiveRecord::Base
  # In order to use number_to_currency
  include ActionView::Helpers::NumberHelper
  extend ActionView::Helpers::NumberHelper

  attr_accessible :invoice, :note, :payment_type, :payment_status, :tip, :transaction_id,
                  :user, :user_attributes, :cart, :cart_id, :store, :store_id,
                  :card_number, :card_verification, :card_expires_on, :tip_rate

  attr_accessor :card_number, :card_verification, :card_expires_on, :tip_rate

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

  TIP_RATES = [['Tip w/ cash', 0], ['Tip 5%', 0.05], ['Tip 10%', 0.1], ['Tip 15%', 0.15], ['Tip 20%', 0.2], ['Tip 25%', 0.25], ['Tip 30%', 0.3]]

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
        :cancel_return  => home_paypal_cancel_url,
        :charset        => 'utf-8',
        :cmd            => '_cart',
        :currency_code  => 'USD',
        :custom         => '',
        :image_url      => "https://meals4.me/assets/mfm_logo.png",
        :invoice        => id,
        :lc             => 'US',
        :no_shipping    => 0,
        :no_note        => 1,
        :notify_url     => home_paypal_notify_url,
        :num_cart_items => cart.cart_items.size,
        :return         => home_stores_url,
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
    client = Savon.client(wsdl: "https://ws.interfax.net/dfs.asmx?WSDL")
    response_interfax = client.call(:send_char_fax, :message => {'Username' => 'wanfenghuaian2', 'Password' => 'gt850829',
                                                                 'FaxNumber' => '9790000000', 'Data' => str, 'FileType' => 'HTML'})

    if response_interfax.body[:send_char_fax_response][:send_char_fax_result].to_i > 0
      puts 'Success'
    else
      puts 'Failure'
    end
  end

  def self.to_phone(order_id)
    @order = Order.find(order_id)

    response_tropo = RestClient.get 'https://api.tropo.com/1.0/sessions', {:params => {
        :token => '1943ff1f022d764787fba66b7531e63fb8c82021f212660238db3991819cf3cb49dc2b85050c879439c0ca67',
        :action => 'create', :phone => '19797396180', :order_id => '003021'}}

    if response_tropo.code == 200
      puts "Msg sent HTTP/#{response_tropo.code}"
    else
      puts "ERROR | HTTP/#{response_tropo.code}"
    end
  end

end
