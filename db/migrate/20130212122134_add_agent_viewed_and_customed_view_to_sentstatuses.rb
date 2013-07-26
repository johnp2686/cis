class AddAgentViewedAndCustomedViewToSentstatuses < ActiveRecord::Migration
  def change
    add_column :sentstatuses, :is_agent_viewed, :boolean
    add_column :sentstatuses, :is_customer_viewed, :boolean
  end
end
