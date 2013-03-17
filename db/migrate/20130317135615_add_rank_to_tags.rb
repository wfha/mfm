class AddRankToTags < ActiveRecord::Migration
  def change
    add_column :tags, :rank, :integer, default: 0, null: false
  end
end
