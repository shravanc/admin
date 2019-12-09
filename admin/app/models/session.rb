class Session < ApplicationRecord
  belongs_to :user

  def login params
    user = params[:user]

    status, data = user.validate_credentials( params \
                                  .require(:session) \
                                  .permit( [:username, :password])
                                            )

=begin
    status, data = user.validate_credentials( params \
                                  .permit( [:username, :password]) )
=end
    unless status
      return [false, data]
    end
    user.sessions << Session.create(session_id: SecureRandom.hex(10))
    data[:session_id] = user.sessions.last.session_id
    [true, data]
  end


private

  def validate_credentials params
    return [false, {message: 'Account not verified'}] unless self.verified
    Rails.logger.warn params
    Rails.logger.warn self.inspect
    encrpyt_pass = encrypt_password params[:password], self.password_salt
    if encrpyt_pass == self.password
      return true, {message: 'Valid credentials'}
    else
      return false, {message: 'Invalid credentials'}
    end
  end

  def encrypt_password password, password_salt
    Rails.logger.warn password
    BCrypt::Engine.hash_secret(password, password_salt)
  end


end
