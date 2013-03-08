class FixCartItems < ActiveRecord::Migration
  def up
    remove_index :cart_items, :dish_id
    change_table :cart_items do |t|
      t.remove :dish_id
      t.belongs_to :cart_itemable, :polymorphic => true
    end
    add_index :cart_items, [:cart_itemable_id, :cart_itemable_type]
  end

  def down
    remove_index :cart_items, [:cart_itemable_id, :cart_itemable_type]
    change_table :cart_items do |t|
      t.remove :cart_itemable_id
      t.remove :cart_itemable_type
      t.references :dish
    end
    add_index :cart_items, :dish_id
  end
end
