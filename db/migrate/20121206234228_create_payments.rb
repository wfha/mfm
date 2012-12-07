class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :desc
      t.string :image

      t.timestamps
    end
  end
end
