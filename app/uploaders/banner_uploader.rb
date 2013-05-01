# encoding: utf-8

class BannerUploader < BaseUploader

  process :resize_to_fill => [1050, 350]

  version :small do
    process :resize_to_fill => [750, 250]
  end

  version :micro do
    process :resize_to_fill => [150, 50]
  end

end
