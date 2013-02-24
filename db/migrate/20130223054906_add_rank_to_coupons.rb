class AddRankToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :rank, :integer, default: 0, null: false
  end
end
