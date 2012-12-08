class Menu < ActiveRecord::Base
  attr_accessible :desc, :name

  belongs_to :store

  has_many :categories, :dependent => :destroy
end
