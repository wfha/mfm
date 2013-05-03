class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed In Successfully!"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication Successful!"
      redirect_to home_index_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.skip_confirmation!     # Users registered with Facebook, Google don't need confirmation
      if user.save
        flash[:notice] = "Signed In Successfully!"
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end
