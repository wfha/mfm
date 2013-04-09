class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :new_ticket

  def create
    super
    session[:omniauth] = nil unless @user.new_record?        # Clear omniauth in the session
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
                             @user.update_with_password(params[:user])
                           else
                             params[:user].delete(:current_password)
                             @user.update_without_password(params[:user])
                           end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  def needs_password?(user, params)
    user.email != params[:user][:email] || !params[:user][:password].empty?
  end

  def new_ticket
    @ticket = Ticket.new
  end

  # Omniauth
  # ====================================
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

end