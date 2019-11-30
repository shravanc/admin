# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Apartment:Switch!('amazon')
user = User.where(username: "admin", firstname: "admin", password: "password").first_or_create
admin = Role.where(title: "admin").first_or_create

privileges = ['create_items', 'update_items', 'destroy_items', 'create_lists', 'destroy_lists', 'create_layouts', 'update_layouts', 'create_media', 'update_media']
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



#Netflix ontent
Apartment:Switch!('netflix')
user = User.where(username: "admin", firstname: "admin", password: "password").first_or_create
admin = Role.where(title: "admin").first_or_create

privileges = ['create_items', 'update_items', 'destroy_items', 'create_lists', 'destroy_lists', 'create_layouts', 'update_layouts', 'create_media', 'update_media']
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

