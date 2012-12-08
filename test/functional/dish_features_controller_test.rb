require 'test_helper'

class DishFeaturesControllerTest < ActionController::TestCase
  setup do
    @dish_feature = dish_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_feature" do
    assert_difference('DishFeature.count') do
      post :create, dish_feature: { desc: @dish_feature.desc, name: @dish_feature.name }
    end

    assert_redirected_to dish_feature_path(assigns(:dish_feature))
  end

  test "should show dish_feature" do
    get :show, id: @dish_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_feature
    assert_response :success
  end

  test "should update dish_feature" do
    put :update, id: @dish_feature, dish_feature: { desc: @dish_feature.desc, name: @dish_feature.name }
    assert_redirected_to dish_feature_path(assigns(:dish_feature))
  end

  test "should destroy dish_feature" do
    assert_difference('DishFeature.count', -1) do
      delete :destroy, id: @dish_feature
    end

    assert_redirected_to dish_features_path
  end
end
