class Transaction < ActiveRecord::Base
  attr_accessible :amount, :desc, :name, :status, :user_id

  belongs_to :user

  # Created in three places:
  # 1. home_controller.rb     -> paypal_notify
  # 2. orders_controller.rb   -> create
  # 3. admin_controller.rb    -> craete_transaction

end
