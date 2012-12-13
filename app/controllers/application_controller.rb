class ApplicationController < ActionController::Base
  protect_from_forgery

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
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create(:store => Store.first)
    session[:cart_id] = cart.id
    cart
  end

  private
  def new_cart
    cart = Cart.create(:store => Store.first)
    session[:cart_id] = cart.id
  end

end
