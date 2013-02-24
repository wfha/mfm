class Coupon < ActiveRecord::Base
  attr_accessible :desc, :end_at, :name, :start_at, :photo, :rank

  belongs_to :store

  mount_uploader :photo, PhotoUploader
end
