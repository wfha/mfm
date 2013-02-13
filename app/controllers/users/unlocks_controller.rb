class Users::UnlocksController < Devise::UnlocksController
  before_filter :new_ticket

  private
  def new_ticket
    @ticket = Ticket.new
  end
end