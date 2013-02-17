class Dish < ActiveRecord::Base
  belongs_to :category

  attr_accessible :desc, :photo, :name, :price, :rank,
                  :dish_feature_ids, :dish_choice_ids, :dish_discount_ids

  has_and_belongs_to_many :dish_discounts
  has_and_belongs_to_many :dish_features
  has_and_belongs_to_many :dish_choices

  mount_uploader :photo, PhotoUploader

  ERROR_MSG = "This dish is currently not available!"
end
