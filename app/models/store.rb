class Store < ActiveRecord::Base
  include Hourable

  attr_accessible :delivery_fee, :delivery_minimum, :delivery_radius,
                  :desc, :fax, :avatar, :name, :phone, :rank, :tag_ids, :payment_ids, :service_ids,
                  :address_attributes, :hours_attributes

  has_one :address, :as => :addressable

  has_many :coupons, :dependent => :destroy
  has_many :dish_choices, :dependent => :destroy
  has_many :dish_features, :dependent => :destroy
  has_many :dish_discounts, :dependent => :destroy
  has_many :hours, :dependent => :destroy, :as => :hourable
  has_many :menus, :dependent => :destroy, :order => :rank
  has_many :plans, :dependent => :destroy
  has_many :orders

  has_and_belongs_to_many :payments
  has_and_belongs_to_many :services
  has_and_belongs_to_many :tags

  # ========== More ==========

  accepts_nested_attributes_for :address, :allow_destroy => true
  accepts_nested_attributes_for :hours, :allow_destroy => true

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :phone, presence: true
  validates :fax, presence: true
  validates :delivery_fee, presence: true
  validates :delivery_minimum, presence: true
  validates :delivery_radius, presence: true

  def has_effective_coupons?
    coupons.where("rank > 0").size > 0
  end

  def can_order_online?
    services.include?(Service.find_by_name("order_online"))
  end

  def can_reserve_online?
    services.include?(Service.find_by_name("reserve_online"))
  end
end
