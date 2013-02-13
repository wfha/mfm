class AddRankToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :rank, :integer, default: 0, null: false
  end
end
