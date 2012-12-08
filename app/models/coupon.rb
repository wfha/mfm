class Coupon < ActiveRecord::Base
  attr_accessible :desc, :end_at, :name, :start_at, :image

  belongs_to :store

  mount_uploader :image, ImageUploader
end
