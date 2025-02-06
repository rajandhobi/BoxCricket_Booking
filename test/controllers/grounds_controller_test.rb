require "test_helper"

class GroundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ground = grounds(:one)
  end

  test "should get index" do
    get grounds_url
    assert_response :success
  end

  test "should get new" do
    get new_ground_url
    assert_response :success
  end

  test "should create ground" do
    assert_difference("Ground.count") do
      post grounds_url, params: { ground: { availabiity: @ground.availabiity, branch_id: @ground.branch_id, capicity: @ground.capicity, city: @ground.city, close_time: @ground.close_time, contact_number: @ground.contact_number, country: @ground.country, description: @ground.description, email: @ground.email, facility: @ground.facility, ground_type: @ground.ground_type, location: @ground.location, name: @ground.name, open_time: @ground.open_time, pincode: @ground.pincode, price_per_hourse: @ground.price_per_hourse, state: @ground.state } }
    end

    assert_redirected_to ground_url(Ground.last)
  end

  test "should show ground" do
    get ground_url(@ground)
    assert_response :success
  end

  test "should get edit" do
    get edit_ground_url(@ground)
    assert_response :success
  end

  test "should update ground" do
    patch ground_url(@ground), params: { ground: { availabiity: @ground.availabiity, branch_id: @ground.branch_id, capicity: @ground.capicity, city: @ground.city, close_time: @ground.close_time, contact_number: @ground.contact_number, country: @ground.country, description: @ground.description, email: @ground.email, facility: @ground.facility, ground_type: @ground.ground_type, location: @ground.location, name: @ground.name, open_time: @ground.open_time, pincode: @ground.pincode, price_per_hourse: @ground.price_per_hourse, state: @ground.state } }
    assert_redirected_to ground_url(@ground)
  end

  test "should destroy ground" do
    assert_difference("Ground.count", -1) do
      delete ground_url(@ground)
    end

    assert_redirected_to grounds_url
  end
end
