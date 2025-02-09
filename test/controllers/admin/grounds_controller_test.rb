require "test_helper"

class Admin::GroundsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_grounds_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_grounds_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_grounds_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_grounds_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_grounds_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_grounds_destroy_url
    assert_response :success
  end
end
