class CreateDishChoicesDishesJoin < ActiveRecord::Migration
  def up
    create_table :dish_choices_dishes, :id => false do |t|
      t.integer :dish_choice_id
      t.integer :dish_id
    end
    add_index :dish_choices_dishes, :dish_choice_id
    add_index :dish_choices_dishes, :dish_id
    add_index :dish_choices_dishes, [:dish_id, :dish_choice_id]
  end

  def down
    drop_table :dish_choices_dishes
  end
end
