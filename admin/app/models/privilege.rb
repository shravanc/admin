class Privilege < ApplicationRecord

has_many :role_privileges
has_many :roles, through: :role_privileges

def create params
  privilege = Privilege.create(privilege_parameters(params))
  message = { message: 'Privilege created succesfully'}
  return [ true, message ]
end

def update params
  privilege = Privilege.find(params[:id])
  privilege.update_attributes(privilege_parameters(params))
  message = { message: 'Privilege updated succesfully'}
  return [ true, message ]
end

private

def privilege_parameters(params)
  params.require(:privilege).permit([:title, :action])
end

end
