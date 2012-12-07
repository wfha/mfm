class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :desc
      t.string :image
      t.string :phone
      t.string :fax
      t.decimal :delivery_minimum
      t.decimal :delivery_fee
      t.integer :delivery_radius

      t.timestamps
    end
  end
end
