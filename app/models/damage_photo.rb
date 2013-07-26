class DamagePhoto < ActiveRecord::Base
  # attr_accessible :title, :body
   belongs_to :damageattachable, :polymorphic => true
  mount_uploader :file, PolicyPhotoUploader
  # mount_uploader :file, ImageUploader
  attr_accessible :file
end
