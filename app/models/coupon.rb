class Coupon < ActiveRecord::Base
  include Hourable

  attr_accessible :desc, :end_at, :name, :start_at, :rank, :price, :scope, :minimum, :hours_attributes,
                  :photo, :photo_cache, :remove_photo # carrierwave and rails_admin

  belongs_to :store

  has_many :cart_items, :as => :cart_itemable
  has_many :hours, :dependent => :destroy, :as => :hourable

  accepts_nested_attributes_for :hours, :allow_destroy => true

  mount_uploader :photo, PhotoUploader

  serialize :scope, Array

  SCOPE_CHOICES = [["In Store", "in_store"], ["Online", "online"]]


  # Encode and Decode this coupon
  def encode_coupon
    ((Date.today.wday + 7)*(Date.today.mday + 7) + (id + 7)*77777 + 7777777).to_s(30)
  end

  def self.decode_coupon(fake_coupon_id)
    (fake_coupon_id.to_i(30) - 7777777 - (Date.today.wday + 7)*(Date.today.mday + 7))/77777 - 7
  end
end
