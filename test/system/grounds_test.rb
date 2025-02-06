require "application_system_test_case"

class GroundsTest < ApplicationSystemTestCase
  setup do
    @ground = grounds(:one)
  end

  test "visiting the index" do
    visit grounds_url
    assert_selector "h1", text: "Grounds"
  end

  test "should create ground" do
    visit grounds_url
    click_on "New ground"

    check "Availabiity" if @ground.availabiity
    fill_in "Branch", with: @ground.branch_id
    fill_in "Capicity", with: @ground.capicity
    fill_in "City", with: @ground.city
    fill_in "Close time", with: @ground.close_time
    fill_in "Contact number", with: @ground.contact_number
    fill_in "Country", with: @ground.country
    fill_in "Description", with: @ground.description
    fill_in "Email", with: @ground.email
    fill_in "Facility", with: @ground.facility
    fill_in "Ground type", with: @ground.ground_type
    fill_in "Location", with: @ground.location
    fill_in "Name", with: @ground.name
    fill_in "Open time", with: @ground.open_time
    fill_in "Pincode", with: @ground.pincode
    fill_in "Price per hourse", with: @ground.price_per_hourse
    fill_in "State", with: @ground.state
    click_on "Create Ground"

    assert_text "Ground was successfully created"
    click_on "Back"
  end

  test "should update Ground" do
    visit ground_url(@ground)
    click_on "Edit this ground", match: :first

    check "Availabiity" if @ground.availabiity
    fill_in "Branch", with: @ground.branch_id
    fill_in "Capicity", with: @ground.capicity
    fill_in "City", with: @ground.city
    fill_in "Close time", with: @ground.close_time.to_s
    fill_in "Contact number", with: @ground.contact_number
    fill_in "Country", with: @ground.country
    fill_in "Description", with: @ground.description
    fill_in "Email", with: @ground.email
    fill_in "Facility", with: @ground.facility
    fill_in "Ground type", with: @ground.ground_type
    fill_in "Location", with: @ground.location
    fill_in "Name", with: @ground.name
    fill_in "Open time", with: @ground.open_time.to_s
    fill_in "Pincode", with: @ground.pincode
    fill_in "Price per hourse", with: @ground.price_per_hourse
    fill_in "State", with: @ground.state
    click_on "Update Ground"

    assert_text "Ground was successfully updated"
    click_on "Back"
  end

  test "should destroy Ground" do
    visit ground_url(@ground)
    click_on "Destroy this ground", match: :first

    assert_text "Ground was successfully destroyed"
  end
end
