require 'test_helper'

class GoalInstancesControllerTest < ActionController::TestCase
  setup do
    @goal_instance = goal_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goal_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal_instance" do
    assert_difference('GoalInstance.count') do
      post :create, goal_instance: { cheer_ons: @goal_instance.cheer_ons, end_date: @goal_instance.end_date, is_complete: @goal_instance.is_complete, start_date: @goal_instance.start_date }
    end

    assert_redirected_to goal_instance_path(assigns(:goal_instance))
  end

  test "should show goal_instance" do
    get :show, id: @goal_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goal_instance
    assert_response :success
  end

  test "should update goal_instance" do
    put :update, id: @goal_instance, goal_instance: { cheer_ons: @goal_instance.cheer_ons, end_date: @goal_instance.end_date, is_complete: @goal_instance.is_complete, start_date: @goal_instance.start_date }
    assert_redirected_to goal_instance_path(assigns(:goal_instance))
  end

  test "should destroy goal_instance" do
    assert_difference('GoalInstance.count', -1) do
      delete :destroy, id: @goal_instance
    end

    assert_redirected_to goal_instances_path
  end
end
