class CartItem < ActiveRecord::Base
  attr_accessible :name, :note, :price, :quantity, :dish_id, :cart_id

  belongs_to :dish
  belongs_to :cart

  def total_price
    price * quantity
  end
end
