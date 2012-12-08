class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :desc
      t.references :store

      t.timestamps
    end
    add_index :menus, :store_id
  end
end
