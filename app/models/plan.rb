class Plan < ActiveRecord::Base
  attr_accessible :desc, :name, :photo, :rank

  belongs_to :store

  mount_uploader :photo, PhotoUploader
end
