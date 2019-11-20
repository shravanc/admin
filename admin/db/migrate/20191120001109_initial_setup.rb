class InitialSetup < ActiveRecord::Migration[5.2]
  def up
    user = User.where(username: "admin", firstname: "admin", password: "password").first_or_create
    admin = Role.where(title: "admin").first_or_create

    privileges = ['create_items', 'update_items', 'destroy_items', 'create_lists', 'destroy_lists', 'create_layouts', 'update_layouts']
    privileges.each do |p1|
      Privilege.where(title: p1).first_or_create
    end

    admin.privileges << Privilege.all


    list_operation = Role.where(title: 'list_operation').first_or_create
    list_operation.privileges << Privilege.find_by(title: 'create_lists')
    list_operation.privileges << Privilege.find_by(title: 'destroy_lists')


    item_operation = Role.where(title: 'item_operation').first_or_create
    item_operation.privileges << Privilege.find_by(title:'create_items')
    item_operation.privileges << Privilege.find_by(title:'update_items')
    item_operation.privileges << Privilege.find_by(title:'destroy_items')


    user.role = admin
  end
end
