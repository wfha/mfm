class CreateDishFeaturesDishesJoin < ActiveRecord::Migration
  def up
    create_table :dish_features_dishes, :id => false do |t|
      t.integer :dish_feature_id
      t.integer :dish_id
    end
    add_index :dish_features_dishes, :dish_feature_id
    add_index :dish_features_dishes, :dish_id
    add_index :dish_features_dishes, [:dish_id, :dish_feature_id]
  end

  def down
    drop_table :dish_features_dishes
  end
end
