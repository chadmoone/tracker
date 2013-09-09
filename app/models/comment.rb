class Comment < ActiveRecord::Base
  before_create :set_previous_state
  after_create :set_issue_state

  belongs_to :user
  belongs_to :issue
  belongs_to :state
  belongs_to :previous_state, class_name: "State"

  validates :body, presence: true

  delegate :project, to: :issue

  private
    def set_previous_state
      self.previous_state = issue.state
    end

    def set_issue_state
      self.issue.state = self.state
      self.issue.save!
    end
end
