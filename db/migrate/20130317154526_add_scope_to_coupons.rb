class AddScopeToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :scope, :text
  end
end
