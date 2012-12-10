class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.belongs_to :addressable, :polymorphic => true

      t.timestamps
    end
    add_index :addresses, [:addressable_id, :addressable_type]
  end
end
