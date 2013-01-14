class Tag < ActiveRecord::Base
  attr_accessible :desc, :name

  has_and_belongs_to_many :stores

  validates :name, presence: true
end
