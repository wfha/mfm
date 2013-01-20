class CreatePaypalNotifications < ActiveRecord::Migration
  def change
    create_table :paypal_notifications do |t|
      t.text :params
      t.references :order
      t.string :status
      t.string :transaction_id
      t.string :create

      t.timestamps
    end
    add_index :paypal_notifications, :order_id
  end
end
