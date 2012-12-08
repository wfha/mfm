class CreateDishFeatures < ActiveRecord::Migration
  def change
    create_table :dish_features do |t|
      t.string :name
      t.string :desc
      t.references :store

      t.timestamps
    end
    add_index :dish_features, :store_id
  end
end
