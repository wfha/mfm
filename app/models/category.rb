class Category < ActiveRecord::Base
  belongs_to :menu
  attr_accessible :desc, :name
end
