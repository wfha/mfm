class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :desc
      t.references :store
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    add_index :coupons, :store_id
  end
end
