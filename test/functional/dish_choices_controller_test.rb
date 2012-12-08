require 'test_helper'

class DishChoicesControllerTest < ActionController::TestCase
  setup do
    @dish_choice = dish_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_choice" do
    assert_difference('DishChoice.count') do
      post :create, dish_choice: { checked: @dish_choice.checked, content: @dish_choice.content, desc: @dish_choice.desc, input_type: @dish_choice.input_type, must: @dish_choice.must, name: @dish_choice.name }
    end

    assert_redirected_to dish_choice_path(assigns(:dish_choice))
  end

  test "should show dish_choice" do
    get :show, id: @dish_choice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_choice
    assert_response :success
  end

  test "should update dish_choice" do
    put :update, id: @dish_choice, dish_choice: { checked: @dish_choice.checked, content: @dish_choice.content, desc: @dish_choice.desc, input_type: @dish_choice.input_type, must: @dish_choice.must, name: @dish_choice.name }
    assert_redirected_to dish_choice_path(assigns(:dish_choice))
  end

  test "should destroy dish_choice" do
    assert_difference('DishChoice.count', -1) do
      delete :destroy, id: @dish_choice
    end

    assert_redirected_to dish_choices_path
  end
end
