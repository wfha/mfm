require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get stores" do
    get :stores
    assert_response :success
  end

  test "should get plans" do
    get :plans
    assert_response :success
  end

  test "should get coupons" do
    get :coupons
    assert_response :success
  end

end
