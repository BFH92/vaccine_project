require "test_helper"

class VaccinatedPeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @@vaccinated_people = vaccinated_people(:one)
  end

  test "should get index" do
    get vaccinated_people_url, as: :json
    assert_response :success
  end

  test "should create @vaccinated_people" do
    assert_difference('@VaccinatedPeople.count') do
      post vaccinated_people_url, params: { @vaccinated_people: { last_vaccination_date: @@vaccinated_people.last_vaccination_date, user_reference: @@vaccinated_people.user_reference, vaccine_reference: @@vaccinated_people.vaccine_reference } }, as: :json
    end

    assert_response 201
  end

  test "should show @vaccinated_people" do
    get @vaccinated_people_url(@@vaccinated_people), as: :json
    assert_response :success
  end

  test "should update @vaccinated_people" do
    patch @vaccinated_people_url(@@vaccinated_people), params: { @vaccinated_people: { last_vaccination_date: @@vaccinated_people.last_vaccination_date, user_reference: @@vaccinated_people.user_reference, vaccine_reference: @@vaccinated_people.vaccine_reference } }, as: :json
    assert_response 200
  end

  test "should destroy @vaccinated_people" do
    assert_difference('@VaccinatedPeople.count', -1) do
      delete @vaccinated_people_url(@@vaccinated_people), as: :json
    end

    assert_response 204
  end
end
