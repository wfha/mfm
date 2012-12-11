class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :quantity, :default => 1
      t.string :note
      t.references :dish
      t.references :cart

      t.timestamps
    end
    add_index :cart_items, :dish_id
    add_index :cart_items, :cart_id
  end
end
