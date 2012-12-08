class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :desc
      t.references :menu

      t.timestamps
    end
    add_index :categories, :menu_id
  end
end
