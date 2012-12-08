class CreateDishChoices < ActiveRecord::Migration
  def change
    create_table :dish_choices do |t|
      t.string :name
      t.string :desc
      t.references :store
      t.boolean :must, :default => false
      t.integer :checked, :default => 0
      t.string :input_type, :default => 'radio'
      t.string :content, :default => 'abc:0,def:1'

      t.timestamps
    end
    add_index :dish_choices, :store_id
  end
end
