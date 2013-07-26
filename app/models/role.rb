class Role < ActiveRecord::Base
  attr_accessible :title, :body,:role
  has_many :users, :through => :user_roles
  has_many :user_roles
  belongs_to :user
end
