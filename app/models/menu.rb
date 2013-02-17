class Menu < ActiveRecord::Base
  include Hourable

  attr_accessible :desc, :name, :rank, :hours_attributes

  belongs_to :store

  has_many :categories, :dependent => :destroy, :order => :rank
  has_many :hours, :dependent => :destroy, :as => :hourable

  accepts_nested_attributes_for :hours, :allow_destroy => true
end
