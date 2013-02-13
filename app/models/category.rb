class Category < ActiveRecord::Base
  attr_accessible :desc, :name, :rank

  belongs_to :menu

  has_many :dishes, :dependent => :destroy, :order => :rank
end
