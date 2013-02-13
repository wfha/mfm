class Users::SessionsController < Devise::SessionsController
  before_filter :new_ticket

  private
  def new_ticket
    @ticket = Ticket.new
  end
end