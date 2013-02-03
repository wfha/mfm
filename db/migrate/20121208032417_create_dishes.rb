class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :desc
      t.decimal :price, :precision => 8, :scale => 2
      t.string :photo # For Carrierwave
      t.references :category

      t.timestamps
    end
    add_index :dishes, :category_id
  end
end
