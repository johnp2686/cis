class AddCompletedStatusToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :completed_status, :boolean, :default => false
  end
end
