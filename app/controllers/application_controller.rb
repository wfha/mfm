class ApplicationController < ActionController::Base
  protect_from_forgery

  # ========== Devise Redirect ==========

  after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  # ========== Mobile ==========

  before_filter :prepare_for_mobile

  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  private
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    if mobile_device?
      if request.format == :js
        request.format = :mjs
      else
        request.format = :mobile
      end
    end
  end

  # ========== Shopping Cart ==========

  private
  def current_cart(store_id)
    Cart.find(session["cart_id_#{store_id}"])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create(:store_id => store_id)
    session["cart_id_#{store_id}"] = cart.id
    cart
  end

  private
  def new_cart(store_id)
    cart = Cart.create(:store_id => store_id)
    session["cart_id_#{store_id}"] = cart.id
  end
end
