class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :invoice
      t.string :transaction_id
      t.string :payment_type, :default => 'Cash', :null => false
      t.string :note
      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
      t.decimal :tip, :default => 0, :precision => 8, :scale => 2
      t.references :store
      t.references :cart
      t.references :user

      t.timestamps
    end
    add_index :orders, :store_id
    add_index :orders, :cart_id
    add_index :orders, :user_id
  end
end
