class AddClaimStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claim_status, :boolean
  end
end
