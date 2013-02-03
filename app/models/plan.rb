class Plan < ActiveRecord::Base
  attr_accessible :desc, :name, :photo

  belongs_to :store

  mount_uploader :photo, PhotoUploader
end
