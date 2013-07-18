class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :issues, dependent: :destroy

end
