class SessionsController < ApplicationController

before_action :validate_username, only: :create
before_action :validate_session, only: [:update_profile, :change_password, :authorize]

before_action :validate_privilege, only: [:authorize]

def create
  session = Session.new
  status, data = session.login(params)
  if status
    render json: data, status: :created
  else
    render json: data, status: :unprocessable_entity
  end
end

def update_profile
  user = User.new
  status, data = user.update(params)
  if status
    render json: data, status: :created
  else
    render json: data, status: :unprocessable_entity
  end
end

def change_password
  user = User.new
  status, data = user.update(params)
  if status
    render json: data, status: :created
  else
    render json: data, status: :unprocessable_entity
  end
end

def destroy
  session = Session.find_by_session_id(params[:id])
  session.destroy
  render json: {message: 'Session destroyed successfully'}, status: :ok
end

def authorize
  render json: {message: "User is Authorized for the operations"}, status: :ok
end

end
