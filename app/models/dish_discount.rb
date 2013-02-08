class DishDiscount < ActiveRecord::Base
  include Hourable

  attr_accessible :desc, :name, :price, :hours_attributes

  belongs_to :store

  has_many :hours, :dependent => :destroy, :as => :hourable

  accepts_nested_attributes_for :hours, :allow_destroy => true

  has_and_belongs_to_many :dishes
end
