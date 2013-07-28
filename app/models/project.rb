class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :issues, dependent: :destroy
  has_many :permissions, as: :thing

  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view",
                                             user_id: user.id })
  end

end
