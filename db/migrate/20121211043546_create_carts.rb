class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :delivery_type, :default => 'delivery', :null => false
      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
      t.references :store

      t.timestamps
    end
    add_index :carts, :store_id
  end
end
