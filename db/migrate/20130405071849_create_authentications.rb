class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_token_expires_at
      t.references :user

      t.timestamps
    end
    add_index :authentications, :user_id
  end
end
