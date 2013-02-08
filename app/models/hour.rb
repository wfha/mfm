class Hour < ActiveRecord::Base
  attr_accessible :close_at, :desc, :name, :open_at

  belongs_to :hourable, :polymorphic => true
end
