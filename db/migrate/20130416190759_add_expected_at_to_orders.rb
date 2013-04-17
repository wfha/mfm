class AddExpectedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :expected_at, :string, default: "ASAP", null: false
  end
end
