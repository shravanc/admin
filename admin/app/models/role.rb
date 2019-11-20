class Role < ApplicationRecord

has_many :role_privileges
has_many :privileges, through: :role_privileges

has_many :user_roles
has_many :users, through: :user_roles

def create params
  role = Role.create(role_parameters(params))
  message = { message: 'Role created succesfully'}
  return [ true, message ]
end

def update params
  role = Role.find(params[:id])
  role.update_attributes(role_parameters(params))
  message = { message: 'Role updated succesfully'}
  return [ true, message ]
end

private

def role_parameters(params)
  params.require(:role).permit([:title, :description])
end

end
