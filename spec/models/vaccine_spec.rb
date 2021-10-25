require 'rails_helper'

RSpec.describe Vaccine, type: :model do

  before(:each) do 
    @vaccine = Vaccine.create(
      name:"vaccine_test",
      reference: "VCCTT234",
      composition: "aceticacide,Chloroplatinic acid",
      vaccine_booster_delay_in_days:90,
      mandatory: true)
    @country = Country.create(name:"France",reference:"FR")
    @countries_where_vaccine_is_already_available = VaccineAvailableByCountry.where(vaccine_id:@vaccine.id)
    @country_related_to_vaccine = VaccineAvailableByCountry.create(vaccine_id:@vaccine.id, country_id: @country.id)
    
  end

  context "validations" do

    it "is valid with valid attributes" do
      expect(@vaccine).to be_a(Vaccine)
      expect(@vaccine).to be_valid
    end

  
    describe "#name" do
      it "should not be valid without vaccine details" do
        bad_vaccine = Vaccine.create(name:"vaccine_test")
        expect(bad_vaccine).not_to be_valid
        expect(bad_vaccine.errors.include?(:reference)).to eq(true)
        expect(bad_vaccine.errors.include?(:composition)).to eq(true)
        expect(bad_vaccine.errors.include?(:vaccine_booster_delay_in_days)).to eq(true)
        expect(bad_vaccine.errors.include?(:mandatory)).to eq(true)
      end
    end
    describe "uniqueness of instance" do
      it "all instances should be unique" do
        duplicate =  Vaccine.create(
          name:"vaccine_test",
          reference: "VCCTT234",
          composition: "aceticacide,Chloroplatinic acid",
          vaccine_booster_delay_in_days:90,
          mandatory: true)
        expect(duplicate).not_to be_valid
      end   
    end

  end

  context "associations" do
    describe "countries" do
      it "should have_many countries" do
        vaccine_available_by_country = VaccineAvailableByCountry.create(vaccine_id:@vaccine.id,country_id:@country.id)
        expect(@vaccine.countries.include?(@country)).to eq(true)
      end
    end
  end
  


  context "public instance methods" do

    describe "update_countries" do
      it "should update countries of the vaccine" do 
        new_country = Country.create(name:"United Kingdom",reference:"UK")
        @countries_where_vaccine_is_already_available = VaccineAvailableByCountry.where(vaccine_id:@vaccine.id)
        array = []
        array.push(@country.id)
        array.push(new_country.id)
        updated_countries = @vaccine.update_countries(@countries_where_vaccine_is_already_available, array)
        expect(@vaccine.country_ids).to eq([@country.id,new_country.id])
      end
    end

    describe "add_global_infos" do
      it "should add_global_infos to vaccine" do 
        hash = {}
        countries = VaccineAvailableByCountry.where(vaccine_id: @vaccine.id)
        @vaccine.add_global_infos(hash,countries)
        expect(hash["reference"]).to eq(@vaccine.reference)
        expect(hash["name"]).to eq(@vaccine.name)
        expect(hash["composition"]).to eq(@vaccine.composition)
        expect(hash["mandatory"]).to eq("yes")
        expect(hash["available_countries"]).to eq(["France"])
      end
    end
    describe "get_countries_names" do
      it "should get countries names of the vaccine" do 
        expect(@vaccine.get_countries_names).to eq(["France"])
      end
    end
    describe "add_user_injections_infos" do
      it "should add user injections infos to hash" do 
        hash = {}
        user_ref="TEST"
        last_vaccination_date = Time.now.to_date
        user_injection = VaccinatedPeople.create(user_reference:user_ref, vaccine_reference: @vaccine.reference,uniq_reference:user_ref+@vaccine.reference ,last_vaccination_date:last_vaccination_date)
        @vaccine.add_user_injections_infos(user_ref,hash)
        expect(hash["last_injection_date"]).to eq(last_vaccination_date)
      end
      
    end
  end

  

end
