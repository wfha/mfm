class DishFeature < ActiveRecord::Base
  attr_accessible :desc, :name

  belongs_to :store

  has_and_belongs_to_many :dishes
end
