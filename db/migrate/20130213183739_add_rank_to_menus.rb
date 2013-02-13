class AddRankToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :rank, :integer, default: 0, null: false
  end
end
