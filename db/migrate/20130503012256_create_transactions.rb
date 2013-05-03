class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :desc
      t.string :status
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :user

      t.timestamps
    end
    add_index :transactions, :user_id
  end
end
