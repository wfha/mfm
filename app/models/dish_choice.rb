class DishChoice < ActiveRecord::Base
  attr_accessible :checked, :content, :desc, :input_type, :must, :name

  belongs_to :store

  has_and_belongs_to_many :dishes
end
