require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  test "should get people" do
    get :people
    assert_response :success
  end

  test "should get follow" do
    get :follow
    assert_response :success
  end

  test "should get unfollow" do
    get :unfollow
    assert_response :success
  end

end
