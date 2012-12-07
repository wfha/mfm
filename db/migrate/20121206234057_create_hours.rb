class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.string :name
      t.string :desc
      t.string :open_at
      t.string :close_at

      t.timestamps
    end
  end
end
