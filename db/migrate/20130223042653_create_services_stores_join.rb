class CreateServicesStoresJoin < ActiveRecord::Migration
  def up
    create_table :services_stores, :id => false do |t|
      t.integer :service_id
      t.integer :store_id
    end
    add_index :services_stores, :service_id
    add_index :services_stores, :store_id
    add_index :services_stores, [:service_id, :store_id]
  end

  def down
    drop_table :services_stores
  end
end
