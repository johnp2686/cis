class Customer < User
    attr_accessible :agent_id, :claims_attributes

    belongs_to :agent
    has_many :claims
    has_many :sentstatuses
    accepts_nested_attributes_for :claims

    after_create :send_mail
    # validates :agent_id, :presence => true
    # =>  validates :policy_number, :presence => true
    #   validates :policy_number, :uniqueness => true
    before_validation :gpt


    def gpt
    self.reset_password_token = User.reset_password_token
    self.reset_password_sent_at = Time.now
    end

    def send_mail
        UserMailer.registration_confirmation(self).deliver
    end

    def create_customer(id)
      end_user = EndUser.find(id)
      self.first_name = end_user.first_name
      self.last_name = end_user.last_name
      self.dob = end_user.dob
      self.mobile = end_user.mobile
      self.gender = end_user.gender
      self.email = end_user.email
      self.user_name = end_user.user_name
      self.agent_id = end_user.agent_id
      self.location = end_user.location
      self.address = end_user.address
      self.zip = end_user.zip
      self.password = User.reset_password_token if self.password == nil
      self.reset_password_token= User.reset_password_token
      self.reset_password_sent_at = Time.now
      self.claim_status = true
      #UserRole.create(:user_id => self.id,:role_id => 3)
      self
    end

end