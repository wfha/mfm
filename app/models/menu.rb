class Menu < ActiveRecord::Base
  attr_accessible :desc, :name, :rank

  belongs_to :store

  has_many :categories, :dependent => :destroy, :order => :rank
end
