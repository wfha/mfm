class GalleryPhoto < ActiveRecord::Base
  attr_accessible :desc, :name, :photo

  belongs_to :gallery

  mount_uploader :photo, PhotoUploader
end
