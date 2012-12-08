class DishFeature < ActiveRecord::Base
  belongs_to :store
  attr_accessible :desc, :name
end
