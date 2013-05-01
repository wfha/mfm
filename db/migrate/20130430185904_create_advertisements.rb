class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :name
      t.string :desc
      t.integer :rank, default: 0, null: false
      t.string :banner
      t.string :target_url
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
