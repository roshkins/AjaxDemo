class User < ActiveRecord::Base
  attr_accessible :username, :password
  
  validates :username, :password_token, :presence => true
  
  def password=(password)
    self.password_token = BCrypt.create(password)
  end
end
