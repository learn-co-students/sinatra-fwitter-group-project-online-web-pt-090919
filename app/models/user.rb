class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets



  def slug
    slug = self.username.parameterize 
    self.slug = slug 
    self.save 
    slug
  end 

  def self.find_by_slug(slug) 
    self.find_by slug: slug
  end 

end
