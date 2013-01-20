require 'test_helper'

class PaypalNotificationsControllerTest < ActionController::TestCase
  setup do
    @paypal_notification = paypal_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paypal_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paypal_notification" do
    assert_difference('PaypalNotification.count') do
      post :create, paypal_notification: { create: @paypal_notification.create, params: @paypal_notification.params, status: @paypal_notification.status, transaction_id: @paypal_notification.transaction_id }
    end

    assert_redirected_to paypal_notification_path(assigns(:paypal_notification))
  end

  test "should show paypal_notification" do
    get :show, id: @paypal_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paypal_notification
    assert_response :success
  end

  test "should update paypal_notification" do
    put :update, id: @paypal_notification, paypal_notification: { create: @paypal_notification.create, params: @paypal_notification.params, status: @paypal_notification.status, transaction_id: @paypal_notification.transaction_id }
    assert_redirected_to paypal_notification_path(assigns(:paypal_notification))
  end

  test "should destroy paypal_notification" do
    assert_difference('PaypalNotification.count', -1) do
      delete :destroy, id: @paypal_notification
    end

    assert_redirected_to paypal_notifications_path
  end
end
