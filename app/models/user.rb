class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  has_many(
    :authored_secrets,
    :class_name => "Secret",
    :foreign_key => "author_id"
  )

  has_many(
    :received_secrets,
    :class_name => "Secret",
    :foreign_key => "recipient_id"
  )

  after_initialize :ensure_session_token

  validates :username, :password_digest, :session_token, :presence => true

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
