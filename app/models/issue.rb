class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  mount_uploader :asset, AssetUploader

  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

end
