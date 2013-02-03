# encoding: utf-8

class AvatarUploader < BaseUploader

  process :resize_to_limit => [200, 200]

  version :small do
    process :resize_to_limit => [64, 64]
  end

  version :micro do
    process :resize_to_limit => [16, 16]
  end

end
