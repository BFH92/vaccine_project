require 'rails_helper'

RSpec.describe VaccinatedPeople, type: :request do
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
    end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new vaccinated_people" do
        expect { 
          post "/vaccinated_people", 
          params: { "vaccinated_people" =>
            { user_reference:"user_test",
              vaccine_reference: "vaccine_reference",
              uniq_reference:"test_reference",
              last_vaccination_date:@last_vaccination_date }}
        }.to change(VaccinatedPeople,:count).by(1)
      end
    end
    
    context "with invalid attributes" do
      it "doest not create a new vacciner" do
        expect { 
          post "/vaccinated_people/", params: { "vaccinated_people" => { user_reference:"user reference, no attributes" } }
        }.to_not change(VaccinatedPeople, :count)
      end
    end
  end
end
