require "application_system_test_case"

class VaccinesTest < ApplicationSystemTestCase
  setup do
    @vaccine = vaccines(:one)
  end

  test "visiting the index" do
    visit vaccines_url
    assert_selector "h1", text: "Vaccines"
  end

  test "creating a Vaccine" do
    visit vaccines_url
    click_on "New Vaccine"

    fill_in "Available country", with: @vaccine.available_country
    fill_in "Composition", with: @vaccine.composition
    check "Mandatory" if @vaccine.mandatory
    fill_in "Name", with: @vaccine.name
    fill_in "Reference", with: @vaccine.reference
    fill_in "Vaccine booster delay in days", with: @vaccine.vaccine_booster_delay_in_days
    click_on "Create Vaccine"

    assert_text "Vaccine was successfully created"
    click_on "Back"
  end

  test "updating a Vaccine" do
    visit vaccines_url
    click_on "Edit", match: :first

    fill_in "Available country", with: @vaccine.available_country
    fill_in "Composition", with: @vaccine.composition
    check "Mandatory" if @vaccine.mandatory
    fill_in "Name", with: @vaccine.name
    fill_in "Reference", with: @vaccine.reference
    fill_in "Vaccine booster delay in days", with: @vaccine.vaccine_booster_delay_in_days
    click_on "Update Vaccine"

    assert_text "Vaccine was successfully updated"
    click_on "Back"
  end

  test "destroying a Vaccine" do
    visit vaccines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vaccine was successfully destroyed"
  end
end
