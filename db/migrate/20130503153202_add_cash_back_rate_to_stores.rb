class AddCashBackRateToStores < ActiveRecord::Migration
  def change
    add_column :stores, :cash_back_rate, :decimal, :precision => 8, :scale => 4 , :default => 0
  end
end
