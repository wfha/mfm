class CreatePaymentsStoresJoin < ActiveRecord::Migration
  def up
    create_table :payments_stores, :id => false do |t|
      t.integer :payment_id
      t.integer :store_id
    end
    add_index :payments_stores, :payment_id
    add_index :payments_stores, :store_id
    add_index :payments_stores, [:payment_id, :store_id]
  end

  def down
    drop_table :payments_stores
  end
end
