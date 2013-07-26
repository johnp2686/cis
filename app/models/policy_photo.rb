class PolicyPhoto < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  mount_uploader :file, PolicyPhotoUploader
  # mount_uploader :file, ImageUploader
  attr_accessible :claim_id, :file
end
