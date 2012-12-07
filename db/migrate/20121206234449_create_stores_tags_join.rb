class CreateStoresTagsJoin < ActiveRecord::Migration
  def up
    create_table 'stores_tags', :id => false do |t|
      t.integer :store_id
      t.integer :tag_id
    end
    add_index :stores_tags, :store_id
    add_index :stores_tags, :tag_id
  end

  def down
    drop_table 'stores_tags'
  end
end
