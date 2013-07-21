class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

end
