require 'unauthorised_access'
class ApplicationController < ActionController::API

  
#In vod platform we want to register all the unauthorised access in the system done from the user. So We have defined two such 
#observers to watch on such activities. It waits for it to be notified on such actions performed. Those two observers are 
#1. email notificiation for the admin and 2. tracking the activity for further analysis of such actions.
def validate_privilege
  #defining the subject for the observer. Then attach all the observer to this to be notified.
  subject = UnauthorisedAccesss.new

  #Email observer
  email_observer = EmailObserver.new
  subject.attach(email_observer)

  #Activity  Observer
  recorder_observer = RecorderObserver.new
  subject.attach(recorder_observer)

  #Currenct Action performed
  privilege = params[:authorize_action] # + '_' + params[:controller]
  privileges = params[:session].user.role.privileges.map(&:title)

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
