class Ticket < ActiveRecord::Base
  attr_accessible :content, :email

  validates :email, presence: true, format: { with: CustomValidators::Email.regex, message: CustomValidators::Email.hint }
  validates :content, presence: true
end
