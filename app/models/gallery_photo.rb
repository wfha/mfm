class GalleryPhoto < ActiveRecord::Base
  attr_accessible :desc, :name,
                  :photo, :photo_cache, :remove_photo # carrierwave and rails_admin

  belongs_to :gallery

  mount_uploader :photo, PhotoUploader
end
