class UserRole < ActiveRecord::Base
  attr_accessible :title, :body, :user_id, :role_id
  belongs_to :user
  belongs_to :role
end
