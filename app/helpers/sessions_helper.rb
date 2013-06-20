module SessionsHelper
  def current_user
    return nil if params[:session_token].nil?
    
    User.find_by_session_token(params[:session_token])
  end

  def login_user(username, password)
    u = User.find_by_username(username)

    return nil if u.nil?
    return nil unless BCrypt::Password.new(u.password_digest) == password

    u.session_token = SecureRandom::urlsafe_base64(32)
    u.save!
    params[:session_token] = u.session_token
    
    u
  end
end
