class Coupon < ActiveRecord::Base
  attr_accessible :desc, :end_at, :name, :start_at, :photo, :rank, :price

  belongs_to :store

  has_many :cart_items, :as => :cart_itemable

  mount_uploader :photo, PhotoUploader
end
