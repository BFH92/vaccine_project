require 'rails_helper'

RSpec.describe Country, type: :model do

  before(:each) do 
    @country = Country.create(name:"France",reference:"FR")
    @vaccine = Vaccine.create(
      name:"vaccine_test",
      reference: "VCCTT234",
      composition: "aceticacide,Chloroplatinic acid",
      vaccine_booster_delay_in_days:90,
      mandatory: true)
  end

  context "validations" do

    it "is valid with valid attributes" do
      expect(@country).to be_a(Country)
      expect(@country).to be_valid
    end

    describe "#name" do
      it "should not be valid without name" do
        bad_country = Country.create(reference:"UK")
        expect(bad_country).not_to be_valid
        expect(bad_country.errors.include?(:name)).to eq(true)
      end
    end

    describe "#reference" do
      it "should not be valid without reference" do
        bad_country = Country.create(name:"United Kingdom")
        expect(bad_country).not_to be_valid
        expect(bad_country.errors.include?(:reference)).to eq(true)
      end
    end
    describe "uniqueness of instance" do
      it "all instances should be unique" do
        duplicate = Country.create(name:"France",reference:"FR")
        expect(duplicate).not_to be_valid
      end   
    end

  end

  context "associations" do

    describe "vaccines" do
      it "should have_many countries" do
        vaccine_available_by_country = VaccineAvailableByCountry.create(vaccine_id:@vaccine.id,country_id:@country.id)
        expect(@country.vaccines.include?(@vaccine)).to eq(true)
      end
    end
  end
end