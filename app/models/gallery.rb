class Gallery < ActiveRecord::Base
  attr_accessible :desc, :name, :gallery_photos_attributes

  belongs_to :galleriable, :polymorphic => true

  has_many :gallery_photos, :dependent => :destroy

  accepts_nested_attributes_for :gallery_photos, :allow_destroy => true
end
