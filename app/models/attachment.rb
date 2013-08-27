class Attachment < ActiveRecord::Base
  mount_uploader :asset, AssetUploader
end
