class Coupon < ActiveRecord::Base
  belongs_to :store
  attr_accessible :desc, :end_at, :name, :start_at
end
