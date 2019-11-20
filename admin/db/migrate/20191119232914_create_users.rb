class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.boolean :verified, default: false
      t.string :password_salt
      t.string :encrypted_password
      t.string :password
      t.string :confirmation_token

      t.timestamps
    end
  end
end
