class AddRequiredFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string, :limit => 50
  	add_column :users, :last_name, :string, :limit => 50
  	add_column :users, :dob, :date
  	add_column :users, :mobile, :string
    add_column :users, :gender, :string
    add_column :users, :location, :string
    add_column :users, :address, :string
    add_column :users, :zip, :integer
  end
end
