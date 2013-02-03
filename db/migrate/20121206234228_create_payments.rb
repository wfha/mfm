class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :desc
      t.string :avatar # For Carrierwave

      t.timestamps
    end
  end
end
