class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :username
  validates_presence_of :username, :email, :password
  has_many :tweets
end
