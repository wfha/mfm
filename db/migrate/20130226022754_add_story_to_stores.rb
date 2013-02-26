class AddStoryToStores < ActiveRecord::Migration
  def change
    add_column :stores, :story, :text
  end
end
