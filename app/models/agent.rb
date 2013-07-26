class Agent < User
  validates :emp_id, :presence => true
  validates :emp_id, :uniqueness => true
  before_validation :gpt
  after_create :send_mail


  has_many :claims
  has_many :customers
  has_many :sentstatuses

  def send_mail
    UserMailer.registration_confirmation(self).deliver
  end
  def gpt
    self.reset_password_token= User.reset_password_token
    self.reset_password_sent_at = Time.now
  end

  def agent_claims
    # User.find
  end
end