class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :user_name, :first_name, :last_name, :emp_id, :dob, :mobile, :gender, :location,
                  :zip, :policy_number, :damage_details,:address, :completed_at, :claim_status,
                  :approved_status


  validates :first_name,:last_name, :user_name, :location, :presence => true
  validates :email, :mobile, :uniqueness => true

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :mobile, :numericality => true,:length => {:minimum => 10, :maximum => 10}
  validates :zip, :numericality => true
  validates_date :dob, :before => lambda { 18.years.ago },
                               :before_message => "must be at least 18 years old"


  has_many :roles, :through => :user_roles
  has_many :user_roles
  has_one :role
  
  before_validation :generate_password
  def generate_password
    self.password = "password" if self.password == nil
    self.password
  end

   # For pagination - It display 10 record per page                           
  def self.per_page
    10
  end


  # def self.current
  #   Thread.current[:user]
  # end

  # def self.current=(user)
  #   Thread.current[:user] = user
  # end


  def create_user(id)
    end_user = EndUser.find(id)
    self.first_name = end_user.first_name
    self.last_name = end_user.self
    last_name.dob = end_user.dob
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

  def self.search(search)
    if search
      self.joins(:claims).where('user_name LIKE ? OR mobile LIKE ? OR email LIKE ? OR policy_number LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%") 
    else
      scoped  
    end
  end

end
