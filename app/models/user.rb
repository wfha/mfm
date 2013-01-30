class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :address, :address_attributes, :firstname, :lastname, :phone

  has_one :address, :as => :addressable

  has_many :orders

  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :address

  validates :email, presence: true, uniqueness: true,
            format: { with: CustomValidators::Email.regex, message: CustomValidators::Email.hint }
  validates :firstname, presence: true,
            format: { with: CustomValidators::Name.regex, message: CustomValidators::Name.hint }
  validates :lastname, presence: true,
            format: { with: CustomValidators::Name.regex, message: CustomValidators::Name.hint }
  validates :password, presence: true, confirmation: true, :on => :create,
            format: { with: CustomValidators::Password.regex, message: CustomValidators::Password.hint }
  validates :phone, presence: true

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

end
