class Plan < ActiveRecord::Base
  attr_accessible :desc, :name, :rank,
                  :photo, :photo_cache, :remove_photo # carrierwave and rails_admin

  belongs_to :store

  mount_uploader :photo, PhotoUploader
end
