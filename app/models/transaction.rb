class Transaction < ActiveRecord::Base
  attr_accessible :amount, :desc, :name, :status, :user_id

  belongs_to :user

  # Created in four places:
  # 1. home_controller.rb     -> paypal_notify
  # 2. orders_controller.rb   -> create
  # 3. admin_controller.rb    -> create_transaction
  # 4. order.rb               -> to_transaction

end
