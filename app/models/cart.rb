class Cart < ActiveRecord::Base
  attr_accessible :delivery_type, :store, :store_id, :cart_items

  belongs_to :store

  has_many :cart_items, :dependent => :destroy
  has_many :orders

  def add_dish(dish_id, name, price, note)
    current_item = cart_items.find_by_dish_id_and_note(dish_id, note)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(dish_id: dish_id, name: name, price: price, note: note)
    end
    current_item
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end
end
