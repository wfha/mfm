class DishChoice < ActiveRecord::Base
  belongs_to :store
  attr_accessible :checked, :content, :desc, :input_type, :must, :name
end
