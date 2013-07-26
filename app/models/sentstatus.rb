class Sentstatus < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :claim_id,:from,:to,:subject,:message, :is_viewed, 
                  :is_customer_viewed, :is_agent_viewed, :customer_id, :agent_id
  # has_many :user_conversations
  # has_many :users, :through => :user_conversations
  belongs_to :agent
  belongs_to :customer
  belongs_to :claim
end
