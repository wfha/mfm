class Payment < ActiveRecord::Base
  attr_accessible :desc, :avatar, :name

  has_and_belongs_to_many :stores

  mount_uploader :avatar, AvatarUploader
end
