class Advertisement < ActiveRecord::Base
  attr_accessible :banner, :desc, :name, :target_url, :end_at, :start_at, :rank

  mount_uploader :banner, BannerUploader
end
