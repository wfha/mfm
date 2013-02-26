class Dish < ActiveRecord::Base
  belongs_to :category

  attr_accessible :desc, :photo, :name, :price, :rank, :gallery_attributes,
                  :dish_feature_ids, :dish_choice_ids, :dish_discount_ids

  has_one :gallery, :as => :galleriable

  has_and_belongs_to_many :dish_discounts
  has_and_belongs_to_many :dish_features
  has_and_belongs_to_many :dish_choices

  accepts_nested_attributes_for :gallery, :allow_destroy => true

  mount_uploader :photo, PhotoUploader

  ERROR_MSG = "This dish is currently not available!"
end
