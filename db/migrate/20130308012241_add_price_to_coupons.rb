class AddPriceToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
