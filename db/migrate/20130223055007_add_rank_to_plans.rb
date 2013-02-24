class AddRankToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :rank, :integer, default: 0, null: false
  end
end
