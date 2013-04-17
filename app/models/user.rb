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

  has_many :orders
  has_many :authentications

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
            format: { with: CustomValidators::Password.regex, message: CustomValidators::Password.hint }, :if => :password_required?
  validates :phone, presence: true, :if => :phone_required?

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid

      if auth.provider == "facebook" || omniauth.provider == 'google_oauth2'
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.firstname = auth.info.first_name
        user.lastname = auth.info.last_name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.save
      elsif auth.provider == "twitter"
        user.oauth_token = auth.credentials.token
        user.firstname = auth.info.name.split[0]
        user.lastname = auth.info.name.split[1]
        user.email = "guest_#{Time.now.to_i}#{rand(99)}@meals4.me"
        user.password = Devise.friendly_token[0,20]
        user.save
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def phone_required?
    if validate_phone
      true
    else
      false
    end
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
