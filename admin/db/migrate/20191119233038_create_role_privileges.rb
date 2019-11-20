class CreateRolePrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :role_privileges do |t|
      t.integer :role_id
      t.integer :privilege_id

      t.timestamps
    end
  end
end
