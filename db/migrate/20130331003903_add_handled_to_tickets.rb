class AddHandledToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :handled, :boolean, default: false, null: false
  end
end
