class AddRankToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :rank, :integer, default: 0, null: false
  end
end
