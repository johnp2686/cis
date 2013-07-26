class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role
      t.timestamps
    end
    Role.create :role => "Admin"
    Role.create :role => "Agent"
    Role.create :role => "User"
  end
end
