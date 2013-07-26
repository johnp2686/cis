class Claim < ActiveRecord::Base
  attr_accessible :claim_description, :damage_details, :date_of_loss, :location_of_loss, 
                  :policy_number, :claim_status, :damage_photo, :policy_document,:policy_worth,
                  :monthly_premium,:policy_photos_attributes,:damage_photos_attributes, :customer_id,
                  :agent_id, :is_damage_occur_your_home, :damage_at_home_description_details, 
                  :is_home_or_any_part_lent_or_sublet, :lent_or_sublet_description, :damage_discovered_date, 
                  :discovered_by, :property_last_seen, :property_last_seen_by, :time_of_police_notified, 
                  :police_reference, :have_made_any_claim_before, :claim_settlement_details, 
                  :are_you_owner_of_lost, :state_the_names_owner, :occupied_home_as_tenant, :are_you_responsible_for_tenancy_agreement, 
                  :limit_of_responsibility, :have_estimates, :estimated_cost_of_repair, :are_you_registered_for_VAT, :are_estimates_sent_late_date, :actual_cost, :claiming_cost
  validates :policy_number, :presence => true
  validates :policy_number, :uniqueness => true

  belongs_to :agent  
  belongs_to :customer
  has_many :sentstatuses
  # has_many :users, :through => :user_claims
  # has_many :user_claims
  # has_many :policy_photos,  :dependent => :destroy
  has_many :policy_photos, :as => :attachable,:class_name => "PolicyPhoto",  :dependent => :destroy
  has_many :damage_photos, :as => :damageattachable, :dependent => :destroy
  accepts_nested_attributes_for :damage_photos
  accepts_nested_attributes_for :policy_photos

  before_create :add_primary_status

  def add_primary_status
    self.claim_status = "Processing"
  end

  #validates :damage_photo, :policy_document, :presence => true
  # mount_uploader :damage_photo, ImageUploader
  # mount_uploader :policy_document, PolicyDocumentUploader

end
