require "test_helper"

class VaccinatedPeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vaccinated_person = vaccinated_people(:one)
  end

  test "should get index" do
    get vaccinated_people_url, as: :json
    assert_response :success
  end

  test "should create vaccinated_person" do
    assert_difference('VaccinatedPerson.count') do
      post vaccinated_people_url, params: { vaccinated_person: { last_vaccination_date: @vaccinated_person.last_vaccination_date, user_reference: @vaccinated_person.user_reference, vaccine_reference: @vaccinated_person.vaccine_reference } }, as: :json
    end

    assert_response 201
  end

  test "should show vaccinated_person" do
    get vaccinated_person_url(@vaccinated_person), as: :json
    assert_response :success
  end

  test "should update vaccinated_person" do
    patch vaccinated_person_url(@vaccinated_person), params: { vaccinated_person: { last_vaccination_date: @vaccinated_person.last_vaccination_date, user_reference: @vaccinated_person.user_reference, vaccine_reference: @vaccinated_person.vaccine_reference } }, as: :json
    assert_response 200
  end

  test "should destroy vaccinated_person" do
    assert_difference('VaccinatedPerson.count', -1) do
      delete vaccinated_person_url(@vaccinated_person), as: :json
    end

    assert_response 204
  end
end
