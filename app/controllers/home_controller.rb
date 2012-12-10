class HomeController < ApplicationController

  before_filter :yelp_client, :only => [:stores, :store]

  def index
  end

  def stores
    @stores = Store.all

    @addresses = Address.find([1,2,3,4,5])
    @json = @addresses.to_gmaps4rails
  end

  def store
    @store = Store.find(params[:id])

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

  private
  def yelp_client
    @client = Yelp::Client.new
  end
end
