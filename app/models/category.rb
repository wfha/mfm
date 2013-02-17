class Category < ActiveRecord::Base
  include Hourable

  attr_accessible :desc, :name, :rank, :hours_attributes

  belongs_to :menu

  has_many :dishes, :dependent => :destroy, :order => :rank
  has_many :hours, :dependent => :destroy, :as => :hourable

  accepts_nested_attributes_for :hours, :allow_destroy => true
end
