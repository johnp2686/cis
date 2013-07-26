class AddImageToEndUsers < ActiveRecord::Migration
  def change
  	add_column :end_users, :image, :string
  end
end
