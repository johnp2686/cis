class AgentSentStatus < ActiveRecord::Migration
 def change
    create_table :agent_status do |t|
	t.integer :user_id
	t.integer :claim_id
        t.string :from
        t.string :to
        t.string :subject
        t.string :message
      t.timestamps
    end
  end
end
