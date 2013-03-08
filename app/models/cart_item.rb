class CartItem < ActiveRecord::Base
  attr_accessible :name, :note, :price, :quantity, :cart_itemable, :cart_id

  belongs_to :cart_itemable, :polymorphic => true
  belongs_to :cart

  def total_price
    price * quantity
  end
end
