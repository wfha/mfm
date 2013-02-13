class AddRankToStores < ActiveRecord::Migration
  def change
    add_column :stores, :rank, :integer, default: 0, null: false
  end
end
