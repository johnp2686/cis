class AddCustomerAgentIdsIsViewedToSentstatus < ActiveRecord::Migration
  def change
    add_column :sentstatuses, :customer_id, :integer
    add_column :sentstatuses, :agent_id, :integer
    add_column :sentstatuses, :is_viewed, :boolean
  end
end
