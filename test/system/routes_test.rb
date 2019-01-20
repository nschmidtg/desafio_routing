require "application_system_test_case"

class RoutesTest < ApplicationSystemTestCase
  setup do
    @route = routes(:one)
  end

  test "visiting the index" do
    visit routes_url
    assert_selector "h1", text: "Routes"
  end

  test "creating a Route" do
    visit routes_url
    click_on "New Route"

    fill_in "Driver", with: @route.driver_id
    fill_in "Ends at", with: @route.ends_at
    fill_in "Load sum", with: @route.load_sum
    fill_in "Load type", with: @route.load_type
    fill_in "Starts at", with: @route.starts_at
    fill_in "Stops ammount", with: @route.stops_ammount
    fill_in "Vehicle", with: @route.vehicle_id
    click_on "Create Route"

    assert_text "Route was successfully created"
    click_on "Back"
  end

  test "updating a Route" do
    visit routes_url
    click_on "Edit", match: :first

    fill_in "Driver", with: @route.driver_id
    fill_in "Ends at", with: @route.ends_at
    fill_in "Load sum", with: @route.load_sum
    fill_in "Load type", with: @route.load_type
    fill_in "Starts at", with: @route.starts_at
    fill_in "Stops ammount", with: @route.stops_ammount
    fill_in "Vehicle", with: @route.vehicle_id
    click_on "Update Route"

    assert_text "Route was successfully updated"
    click_on "Back"
  end

  test "destroying a Route" do
    visit routes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Route was successfully destroyed"
  end
end
