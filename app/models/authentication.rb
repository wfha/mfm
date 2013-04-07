class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :oauth_token, :oauth_token_expires_at, :provider, :uid
end
