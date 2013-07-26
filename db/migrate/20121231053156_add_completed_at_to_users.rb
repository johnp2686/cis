class AddCompletedAtToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :completed_at, :date
  end
end
