class Issue < ActiveRecord::Base
  belongs_to :project
  
  has_many :attachments
  accepts_nested_attributes_for :attachments
  # mount_uploader :asset, AssetUploader
  
  belongs_to :user
  validates :user, presence: true

  has_and_belongs_to_many :watchers, join_table: "issue_watchers",
                                     class_name: "User"
  
  has_many :comments

  belongs_to :state

  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

  after_create :creator_watches_me

  private
    def creator_watches_me
      if user
        self.watchers << user unless self.watchers.include?(user)
      end
    end

end
