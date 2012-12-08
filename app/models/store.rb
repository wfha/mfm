class Store < ActiveRecord::Base
  attr_accessible :delivery_fee, :delivery_minimum, :delivery_radius, :desc, :fax, :image, :name, :phone, :tag_ids, :payment_ids

  has_many :coupons, :dependent => :destroy
  has_many :dish_choices, :dependent => :destroy
  has_many :dish_features, :dependent => :destroy
  has_many :hours, :dependent => :destroy
  has_many :menus, :dependent => :destroy
  has_many :plans, :dependent => :destroy

  has_and_belongs_to_many :payments
  has_and_belongs_to_many :tags
end
