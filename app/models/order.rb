class Order < ActiveRecord::Base
  attr_accessible :delivery_fee, :invoice, :note, :payment_type, :tip, :transaction_id,
                  :user, :user_attributes, :cart, :cart_id, :store, :store_id

  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  PAYMENT_TYPES = ['Cash', 'Credit Card']
end
