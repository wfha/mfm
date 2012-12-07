class Store < ActiveRecord::Base
  attr_accessible :delivery_fee, :delivery_minimum, :delivery_radius, :desc, :fax, :image, :name, :phone, :tag_ids, :payment_ids

  has_many :hours, :dependent => :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :payments
end
