class UserMail < ActiveRecord::Base
  attr_accessible :title, :body,:from,:to,:subject
  validates :to, :subject, :presence => true

end
