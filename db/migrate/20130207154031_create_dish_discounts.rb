class CreateDishDiscounts < ActiveRecord::Migration
  def change
    create_table :dish_discounts do |t|
      t.string :name
      t.string :desc
      t.decimal :price
      t.references :store

      t.timestamps
    end
    add_index :dish_discounts, :store_id
  end
end
