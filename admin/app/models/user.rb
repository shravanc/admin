class User < ApplicationRecord
  has_many :sessions

    has_one :user_role
    has_one :role, through: :user_role


  before_save :set_password_salt
  before_create :set_confirmation_token
  after_create :send_welcome_email

  validates :username, uniqueness: true

  def register params
    user = User.create(user_parameters(params))
    message = { message: 'user created succesfully'}
    return [ true, message ]
  end

  def update params
    user = params[:session].user
    user.update_attributes(user_parameters(params))
  end

  def validate_credentials params
    return [false, {message: 'Account not verified'}] unless self.verified
    logger.warn params
    logger.warn self.inspect
    encrpyt_pass = encrypt_password params[:password], self.password_salt
    if encrpyt_pass == self.password
      return true, {message: 'Valid credentials'}
    else
      return false, {message: 'Invalid credentials'}
    end
  end

  def forgot_password params
    user = params[:user]
    user.sessions.delete_all
    set_confirmation_token
    user.save
    send_forgot_email
    [true, {messsage: 'Please check mail to create new password'}]
  end

  def set_password params
    user = user_by_token(params[:token])
    user.update_attributes(params.require(:user).permit(:password))
    [true, {message: 'Updated password successfully'}]
  end

  def confirmation params
    user = user_by_token(params[:token])
    if user.nil?
      return [false, {message: 'Invlaid token'}]
    end
    user.update_attributes({verified: true})
    return [true, {message: 'Account confirmed. Now it is safe to access the account.'}]
  end

  private

  # there are set of task that are to be done after a user is created. We are handling it with Chain of Responsibility Design Pattern
  def mandatory_before_save_operations
    # Defining handlers for each responsibility. One to Encrypt user password and another to send notification of registration. More can come in future.
    encrypt = EncryptPassword.new
    notify = SendNotification.new

    #register each responsibility beofre, each request is served.
    encrypt.next_handler(notify) # .next_handler(something_else_1).next_handler(something_else_2)

    #After regitering the responsibility like above. Each requests/taskare performed one after the another.
    ["encrypt", "notify"].each do |request|
      encrypt.handle(request)
    end
  end

  def user_by_token token
    User.find_by_confirmation_token(token)
  end

  def user_parameters(params)
    params.require(:user).permit([:username, :firstname, :lastname, :email, :mobile_phone, :language, :password])
  end

  def encrypt_password password, password_salt
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def set_password_salt
    return unless self.password_changed?
    self.password_salt = BCrypt::Engine.generate_salt
    self.password = encrypt_password(self.password, self.password_salt)
  end

  def set_confirmation_token
    self.confirmation_token = SecureRandom.hex(3).upcase
  end

  def send_welcome_email
    if self.username != "admin"
      UserMailer.welcome_email({user: self, subject: 'Welcome to happines!!!', confirmation_url: "http://localhost:3000/users/confirmation?token=#{self.confirmation_token}"}).deliver_now
    else
      self.verified =true
    end
  end

  def send_forgot_email
    UserMailer.forgot_password({user: self, subject: 'Ooops forgot password. No Worries, create new account :p', confirmation_url: "http://localhost:3000/users/set_password/#{self.confirmation_token}"}).deliver_now
  end


end
