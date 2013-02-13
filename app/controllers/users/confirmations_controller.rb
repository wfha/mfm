class Users::ConfirmationsController < Devise::ConfirmationsController
  before_filter :new_ticket

  private
  def new_ticket
    @ticket = Ticket.new
  end
end