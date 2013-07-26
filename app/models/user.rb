class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :issues
  validates :email, presence: true

  def name 
    "#{firstname} #{lastname}"
  end

  def to_s
    "#{name} - #{email} (#{admin? ? 'Admin' : 'User'})"
  end
end
