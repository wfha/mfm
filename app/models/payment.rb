class Payment < ActiveRecord::Base
  attr_accessible :desc, :name,
                  :avatar, :avatar_cache, :remove_avatar # carrierwave and rails_admin

  has_and_belongs_to_many :stores

  mount_uploader :avatar, AvatarUploader
end
