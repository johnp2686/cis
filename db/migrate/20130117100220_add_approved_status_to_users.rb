class AddApprovedStatusToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :approved_status, :boolean
  end
end
