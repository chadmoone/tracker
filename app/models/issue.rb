class Issue < ActiveRecord::Base
  belongs_to :project
  
  has_many :attachments
  accepts_nested_attributes_for :attachments
  # mount_uploader :asset, AssetUploader
  
  belongs_to :user
  validates :user, presence: true
  
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

end
