class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :payment_type, :default => 'cash', :null => false
      t.string :payment_status, :default => 'not_paid', :null => false
      t.string :note
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
