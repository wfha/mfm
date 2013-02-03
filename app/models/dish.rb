class Dish < ActiveRecord::Base
  belongs_to :category

  attr_accessible :desc, :photo, :name, :price, :dish_feature_ids, :dish_choice_ids

  has_and_belongs_to_many :dish_features
  has_and_belongs_to_many :dish_choices

  mount_uploader :photo, PhotoUploader
end
