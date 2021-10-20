require "test_helper"

class VaccinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vaccine = vaccines(:one)
  end

  test "should get index" do
    get vaccines_url
    assert_response :success
  end

  test "should get new" do
    get new_vaccine_url
    assert_response :success
  end

  test "should create vaccine" do
    assert_difference('Vaccine.count') do
      post vaccines_url, params: { vaccine: { available_country: @vaccine.available_country, composition: @vaccine.composition, mandatory: @vaccine.mandatory, name: @vaccine.name, reference: @vaccine.reference, vaccine_booster_delay_in_days: @vaccine.vaccine_booster_delay_in_days } }
    end

    assert_redirected_to vaccine_url(Vaccine.last)
  end

  test "should show vaccine" do
    get vaccine_url(@vaccine)
    assert_response :success
  end

  test "should get edit" do
    get edit_vaccine_url(@vaccine)
    assert_response :success
  end

  test "should update vaccine" do
    patch vaccine_url(@vaccine), params: { vaccine: { available_country: @vaccine.available_country, composition: @vaccine.composition, mandatory: @vaccine.mandatory, name: @vaccine.name, reference: @vaccine.reference, vaccine_booster_delay_in_days: @vaccine.vaccine_booster_delay_in_days } }
    assert_redirected_to vaccine_url(@vaccine)
  end

  test "should destroy vaccine" do
    assert_difference('Vaccine.count', -1) do
      delete vaccine_url(@vaccine)
    end

    assert_redirected_to vaccines_url
  end
end
