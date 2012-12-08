class Category < ActiveRecord::Base
  attr_accessible :desc, :name

  belongs_to :menu

  has_many :dishes, :dependent => :destroy
end
