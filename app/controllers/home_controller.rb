class HomeController < ApplicationController

  before_filter :yelp_client, :only => [:stores, :store]

  def index
  end

  def stores
    @stores = Store.all

    @addresses = Address.all
    @json = @addresses.to_gmaps4rails


  end

  def store
    @store = Store.find(params[:id])
    @cart = current_cart

    request = Yelp::Phone::Request::Number.new(
        :phone_number => @store.phone,
        :yws_id => '00CRzCP7C-1GMSGy3su_Ig')
    response = @client.search(request)
    @reviews = response["businesses"]
  end

  def plans
    @plans = Plan.all
  end

  def coupons
    @coupons = Coupon.all
  end

  def load_store_info
    @store = Store.find(params[:store_id])

    respond_to do |format|
      format.js
    end
  end

  private
  def yelp_client
    @client = Yelp::Client.new
  end
end
