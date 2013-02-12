class AddHandledToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :handled, :boolean, default: false, null: false
  end
end
