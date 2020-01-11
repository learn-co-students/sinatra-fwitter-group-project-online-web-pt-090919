class User < ActiveRecord::Base
  # responds to authenticate method from has_secure_password
  # works in conjunction w/ gem bcrypt and gives us all of those abilities 
  # in a secure way that doesn't actually store the plain text password
  has_secure_password
  validates_presence_of :email, :username, :password
  # attr_accessor :password_digest
  has_many :tweets
  
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
