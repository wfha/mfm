class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :desc
      t.integer :rank, default: 0, null: false

      t.timestamps
    end
  end
end
