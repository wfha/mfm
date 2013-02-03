# encoding: utf-8

class PhotoUploader < BaseUploader

  process :resize_to_fill => [800, 600]

  version :small do
    process :resize_to_fill => [400, 300]
  end

  version :micro do
    process :resize_to_fill => [160, 120]
  end

end
