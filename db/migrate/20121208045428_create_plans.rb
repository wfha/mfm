class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :desc
      t.string :image
      t.references :store

      t.timestamps
    end
    add_index :plans, :store_id
  end
end
