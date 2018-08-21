require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    @listing = listings(:one)
  end

  test "visiting the index" do
    visit listings_url
    assert_selector "h1", text: "Listings"
  end

  test "creating a Listing" do
    visit listings_url
    click_on "New Listing"

    fill_in "Active", with: @listing.active
    fill_in "Bathroom", with: @listing.bathroom
    fill_in "City", with: @listing.city_id
    fill_in "Home Type", with: @listing.home_type
    fill_in "Latitude", with: @listing.latitude
    fill_in "Listing Name", with: @listing.listing_name
    fill_in "Longitude", with: @listing.longitude
    fill_in "Max Guest", with: @listing.max_guest
    fill_in "Price", with: @listing.price
    fill_in "Room", with: @listing.room
    fill_in "Room Type", with: @listing.room_type
    fill_in "Summary", with: @listing.summary
    fill_in "User", with: @listing.user_id
    click_on "Create Listing"

    assert_text "Listing was successfully created"
    click_on "Back"
  end

  test "updating a Listing" do
    visit listings_url
    click_on "Edit", match: :first

    fill_in "Active", with: @listing.active
    fill_in "Bathroom", with: @listing.bathroom
    fill_in "City", with: @listing.city_id
    fill_in "Home Type", with: @listing.home_type
    fill_in "Latitude", with: @listing.latitude
    fill_in "Listing Name", with: @listing.listing_name
    fill_in "Longitude", with: @listing.longitude
    fill_in "Max Guest", with: @listing.max_guest
    fill_in "Price", with: @listing.price
    fill_in "Room", with: @listing.room
    fill_in "Room Type", with: @listing.room_type
    fill_in "Summary", with: @listing.summary
    fill_in "User", with: @listing.user_id
    click_on "Update Listing"

    assert_text "Listing was successfully updated"
    click_on "Back"
  end

  test "destroying a Listing" do
    visit listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Listing was successfully destroyed"
  end
end
