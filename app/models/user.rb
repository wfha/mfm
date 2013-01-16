class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :address, :address_attributes, :firstname, :lastname, :phone

  attr_accessor :validate_phone

  has_one :address, :as => :addressable

  has_many :orders

  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :address

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true, :on => :update
  validates :phone, presence: true, :on => :create, :if => :validate_phone

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

end
