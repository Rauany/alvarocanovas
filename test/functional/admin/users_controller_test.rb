require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @user = User.find_by_email('nicolas.papon@w3bflows.com')
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_user" do
    assert_difference('User.count') do
      post :create, :admin_user => @user.attributes
    end

    assert_redirected_to admin_user_path(assigns(:admin_user))
  end

  test "should show admin_user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update admin_user" do
    put :update, :id => @user.to_param, :admin_user => @user.attributes
    assert_redirected_to admin_user_path(assigns(:admin_user))
  end

  test "should destroy admin_user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to admin_users_path
  end
end
