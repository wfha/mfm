class CreateDishDiscountsDishesJoin < ActiveRecord::Migration
  def up
    create_table :dish_discounts_dishes, :id => false do |t|
      t.integer :dish_discount_id
      t.integer :dish_id
    end
    add_index :dish_discounts_dishes, :dish_discount_id
    add_index :dish_discounts_dishes, :dish_id
    add_index :dish_discounts_dishes, [:dish_discount_id, :dish_id]
  end

  def down
    drop_table :dish_discounts_dishes
  end
end
