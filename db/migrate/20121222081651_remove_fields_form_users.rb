class RemoveFieldsFormUsers < ActiveRecord::Migration
  def up
    remove_column :users, :email
    remove_column :users, :password_hash
    remove_column :users, :password_salt
    remove_column :users, :role
  end

  def down
    add_column :users, :email, :string 
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    add_column :users, :role, :string
  end
end
