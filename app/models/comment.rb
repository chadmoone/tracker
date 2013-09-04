class Comment < ActiveRecord::Base
  after_create :set_issue_state

  belongs_to :user
  belongs_to :issue
  belongs_to :state
  validates :body, presence: true

  delegate :project, to: :issue

  private

    def set_issue_state
      self.issue.state = self.state
      self.issue.save!
    end
end
