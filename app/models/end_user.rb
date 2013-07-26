class EndUser < ActiveRecord::Base
  attr_accessible :title, :body,:first_name, :last_name, :email, :user_name, :dob, :mobile, :location,
                   :zip, :policy_number,:policy_company_name, :damage_details,:gender,:agent_id,:image, :remote_image_url, :claims_status

    validates :first_name,:last_name,:user_name,:email,:mobile, :location, :zip, :policy_number,:policy_company_name,:damage_details, :presence => true
    validates :user_name,:email,:mobile, :uniqueness => true
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
    validates :mobile, :numericality => true,:length => {:minimum => 10, :maximum => 10}
    validates :zip, :numericality => true
    #validate :mydate_is_date? 
    # validates :image, :presence => true
    #validates :dob, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}
    validates_date :dob, :before => lambda { 18.years.ago },
                               :before_message => "must be at least 18 years old"

    #mount_uploader :image, ImageUploader

    def self.end_users
      self.where(:agent_id => "#{current_user.id}", :claims_status => "false")
    end
    
    def self.current_user
      Thread.current[:current_user]
    end

    def self.current_user=(usr)
      Thread.current[:current_user] = usr
    end

    def self.per_page
      10
    end

  def self.search(search)
      if search
        where('user_name LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR mobile LIKE ? OR location LIKE ? OR damage_details LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%") 
      else
        scoped
      end
  end


  private

  # def mydate_is_date?
  #   if !dob.is_a?(Date)
  #     errors.add(:DateOfBirth, 'must be a valid date') 
  #   end
  # end
end
