require 'rails_helper'

RSpec.describe VaccineAvailableByCountry, type: :model do

  before(:each) do 
    @vaccine = Vaccine.create(
      name:"vaccine_test",
      reference: "VCCTT234",
      composition: "aceticacide,Chloroplatinic acid",
      vaccine_booster_delay_in_days:90,
      mandatory: true)
    @country = Country.create(name:"France",reference:"FR")
    @vaccine_available_for_a_country = VaccineAvailableByCountry.create(vaccine_id: @vaccine.id, country_id: @country.id)

  # en général, tu as envie de créer une nouvelle instance
  end



  context "validations" do

    it "is valid with valid attributes" do
      expect(@vaccine_available_for_a_country).to be_a(VaccineAvailableByCountry)
      expect(@vaccine_available_for_a_country).to be_valid
    end

    describe "#country" do
      it "should not be valid without country_id" do
        bad_availability =  VaccineAvailableByCountry.create(vaccine_id:@vaccine.id)
        expect(bad_availability).not_to be_valid
      end
      it "country must exist" do
        unknown_country_id = 1000
        bad_availability =  VaccineAvailableByCountry.create(vaccine_id:@vaccine.id, country_id:unknown_country_id )
        expect(bad_availability).not_to be_valid
      end
    end
    describe "#vaccine" do
      it "should not be valid without vaccine_id" do
        bad_availability =  VaccineAvailableByCountry.create(country_id:@country.id)
        expect(bad_availability).not_to be_valid
      end
      it "vaccine must exist" do
        unknown_vaccine_id = 2000
        bad_availability =  VaccineAvailableByCountry.create(country_id:@country.id, country_id:unknown_vaccine_id )
        expect(bad_availability).not_to be_valid
      end
    end

  end

  context "associations" do
    describe "vaccines" do
      it "should belong to vaccine" do
        vaccine_available_by_country = VaccineAvailableByCountry.create(vaccine_id:@vaccine.id,country_id:@country.id)
        expect(vaccine_available_by_country.vaccine.name.include?("vaccine_test")).to eq(true)
      end
    end
    describe "countries" do
      it "should belong to country" do
        vaccine_available_by_country = VaccineAvailableByCountry.create(vaccine_id:@vaccine.id,country_id:@country.id)
        expect(vaccine_available_by_country.country.name.include?("France")).to eq(true)
      end
    end
  end

  context "public instance methods" do

    describe "create_custom_infos" do
      it "should updated custom_info to list" do 
        list = []
        user_ref= "TEST"
        @vaccine_available_for_a_country.create_custom_infos(list,user_ref)
        expect(list.first["name"]).to eq("vaccine_test")
      end
    end

  end

end