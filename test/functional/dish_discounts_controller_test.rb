require 'test_helper'

class DishDiscountsControllerTest < ActionController::TestCase
  setup do
    @dish_discount = dish_discounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_discounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_discount" do
    assert_difference('DishDiscount.count') do
      post :create, dish_discount: { desc: @dish_discount.desc, name: @dish_discount.name, price: @dish_discount.price }
    end

    assert_redirected_to dish_discount_path(assigns(:dish_discount))
  end

  test "should show dish_discount" do
    get :show, id: @dish_discount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_discount
    assert_response :success
  end

  test "should update dish_discount" do
    put :update, id: @dish_discount, dish_discount: { desc: @dish_discount.desc, name: @dish_discount.name, price: @dish_discount.price }
    assert_redirected_to dish_discount_path(assigns(:dish_discount))
  end

  test "should destroy dish_discount" do
    assert_difference('DishDiscount.count', -1) do
      delete :destroy, id: @dish_discount
    end

    assert_redirected_to dish_discounts_path
  end
end
