require 'rails_helper'

RSpec.describe Api, type: :request do
  before(:each) do 
    @vaccine= Vaccine.create(
      name:"vaccine_test",
      reference: "VCCTT234",
      composition: "aceticacide,Chloroplatinic acid",
      vaccine_booster_delay_in_days:90,
      mandatory: true)
    @user_ref = "user_test"
    @last_vaccination_date = Time.now.to_date
    @vaccinated_people = VaccinatedPeople.create(
     user_reference:@user_ref,
     vaccine_reference: @vaccine.reference,
     uniq_reference:@user_ref+@vaccine.reference,
     last_vaccination_date:@last_vaccination_date)
     @country = Country.create(
      name:"France",
      reference: "FR",
    )
    end
  

  describe "update_vaccination_tracking" do
    
    it "update vaccinated_people data" do
    @last_vaccination_date_updated = @last_vaccination_date+1
    post "/update-tracking", params: {user_reference:@user_ref,vaccine_reference: @vaccine.reference,uniq_reference:@user_ref+@vaccine.reference, last_vaccination_date: @last_vaccination_date_updated} 
    @vaccinated_people.reload
    @vaccinated_people.last_vaccination_date.should eq(@last_vaccination_date_updated )

    end
    
  end
  describe "get_vaccines_datas_by_country_and_user" do
    
    it "render a list of vaccines " do
    get "/vaccines-list", params: {country:@country.reference, page:1} 
      expect(response.status).to eq(200)
    end
    
  end

end