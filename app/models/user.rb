class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password, :on => :create  

  # attr_accessor :password, :password_confirmation
end
