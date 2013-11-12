require 'test_helper'

class MilstonesControllerTest < ActionController::TestCase
  setup do
    @milstone = milstones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:milstones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create milstone" do
    assert_difference('Milstone.count') do
      post :create, milstone: { description: @milstone.description, goal_instance: @milstone.goal_instance, no_of_days: @milstone.no_of_days, title: @milstone.title }
    end

    assert_redirected_to milstone_path(assigns(:milstone))
  end

  test "should show milstone" do
    get :show, id: @milstone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @milstone
    assert_response :success
  end

  test "should update milstone" do
    put :update, id: @milstone, milstone: { description: @milstone.description, goal_instance: @milstone.goal_instance, no_of_days: @milstone.no_of_days, title: @milstone.title }
    assert_redirected_to milstone_path(assigns(:milstone))
  end

  test "should destroy milstone" do
    assert_difference('Milstone.count', -1) do
      delete :destroy, id: @milstone
    end

    assert_redirected_to milstones_path
  end
end
