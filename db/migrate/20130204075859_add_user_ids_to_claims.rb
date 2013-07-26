class AddUserIdsToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :customer_id, :integer
    add_column :claims, :agent_id, :integer
  end
end
