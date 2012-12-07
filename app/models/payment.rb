class Payment < ActiveRecord::Base
  attr_accessible :desc, :image, :name

  has_and_belongs_to_many :stores
end
