class Plan < ActiveRecord::Base
  attr_accessible :desc, :name, :image

  belongs_to :store

  mount_uploader :image, ImageUploader
end
