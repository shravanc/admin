require 'unauthorised_access'
class ApplicationController < ActionController::API

def validate_privilege
  subject = UnauthorisedAccesss.new
  email_observer = EmailObserver.new
  subject.attach(email_observer)
  recorder_observer = RecorderObserver.new
  subject.attach(recorder_observer)

  privilege = params[:authorize_action] # + '_' + params[:controller]
  privileges = params[:session].user.role.privileges.map(&:title)
  Rails.logger.warn privileges
  Rails.logger.warn privilege
  if privileges.include? privilege
    render json: {message: "Valid User"}, status: :ok
  else
    subject.alaram_operation privilege
    render json: {message: "Invalid User"}, status: :unprocessable_entity
  end

end

def validate_session
  logger.warn params
  @session = Session.find_by_session_id(params[:session_id])
  if @session.nil?
    data = {errors: [{code: 123, message: 'session could not be found'}], message: 'Invalid session'}
    render json: data, status: :unprocessable_entity
    return
  else
    @session.user.touch
  end
  params[:session] = @session
  return
end

def validate_username
  username = params[:action] == 'forgot_password' ? params[:user][:username] : params[:session][:username]
  #username = params[:action] == 'forgot_password' ? params[:user][:username] : params[:username]
  Rails.logger.warn username
  Rails.logger.warn User.last.as_json
  user = User.find_by_username(username)
  if user.nil?
    render json: {message: 'Invalid username'}, status: :unauthorized
    return
  end
  params[:user] = user
end
end
