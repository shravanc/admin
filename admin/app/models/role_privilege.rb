class RolePrivilege < ApplicationRecord
belongs_to :role
belongs_to :privilege
end
