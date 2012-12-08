class Dish < ActiveRecord::Base
  belongs_to :category
  attr_accessible :desc, :image, :name, :price
end
