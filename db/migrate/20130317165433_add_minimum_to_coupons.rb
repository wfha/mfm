class AddMinimumToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :minimum, :decimal, :precision => 8, :scale => 2, :default => 20.0
  end
end
