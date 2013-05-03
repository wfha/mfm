class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :address, :address_attributes, :firstname, :lastname, :phone,
                  :avatar, :avatar_cache, :remove_avatar  # carrierwave and rails_admin

  # Condition to validate phone
  attr_accessor :validate_phone

  has_one :address, :as => :addressable

  has_many :orders              # For getting all the orders for this user
  has_many :authentications     # For signing in with Facebook and Google
  has_many :transactions        # For calculating cash back balance for this user

  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :address

  mount_uploader :avatar, AvatarUploader

  # Validate the avatar picture
  # =======================================================
  #validates_presence_of   :avatar
  #validates_integrity_of  :avatar
  #validates_processing_of :avatar

  validates :email, presence: true, uniqueness: true,
            format: { with: CustomValidators::Email.regex, message: CustomValidators::Email.hint }
  validates :firstname, presence: true,
            format: { with: CustomValidators::Name.regex, message: CustomValidators::Name.hint }
  validates :lastname, presence: true,
            format: { with: CustomValidators::Name.regex, message: CustomValidators::Name.hint }
  validates :password, presence: true, confirmation: true, :on => :create,
            format: { with: CustomValidators::Password.regex, message: CustomValidators::Password.hint }
  validates :phone, presence: true, :if => :phone_required?

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Skip password for users that use facebook and google to sign in
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  # Skip phone validation when sign up
  def phone_required?
    if validate_phone
      true
    else
      false
    end
  end

  def cash_back
    b = 0
    transactions.each do |tran|
      b += tran.amount
    end
    b
  end

  def facebook
    oauth_token = authentications.find_by_provider("facebook").oauth_token
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end

  def friends_count
    facebook.get_connection("me", "friends").size
  end

  def apply_omniauth(omniauth)
    self.firstname = omniauth.info.first_name if firstname.blank?
    self.lastname = omniauth.info.last_name if lastname.blank?

    if omniauth.provider == 'facebook' || omniauth.provider == 'google_oauth2'
      self.email = omniauth.info.email if email.blank?       # Save Email
      self.remote_avatar_url = omniauth.info.image           # Save Remote Picture
      authentications.build(
          :provider => omniauth.provider, :uid => omniauth.uid,
          :oauth_token => omniauth.credentials.token,
          :oauth_token_expires_at => Time.at(omniauth.credentials.expires_at)
      )
    elsif omniauth.provider == 'twitter'
      authentications.build(:provider => omniauth.provider, :uid => omniauth.uid)
    end
  end
end
