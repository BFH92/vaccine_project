require 'rails_helper'

RSpec.describe VaccinatedPeople, type: :model do

  before(:each) do 
    @vaccine = Vaccine.create(
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



  context "validations" do

    it "is valid with valid attributes" do
      expect(@vaccinated_people).to be_a(VaccinatedPeople)
      expect(@vaccinated_people).to be_valid
    end

    describe "#user_reference" do
      it "should not be valid without #user_reference" do
        bad_vaccinated_people = VaccinatedPeople.create(vaccine_reference:"vaccine_reference")
        expect(bad_vaccinated_people).not_to be_valid
        expect(bad_vaccinated_people.errors.include?(:user_reference)).to eq(true)
      end   
    end
    describe "#vaccine_reference" do
      it "should not be valid without #vaccine_reference" do
        bad_vaccinated_people = VaccinatedPeople.create(user_reference:"vaccine_reference")
        expect(bad_vaccinated_people).not_to be_valid
        expect(bad_vaccinated_people.errors.include?(:vaccine_reference)).to eq(true)
      end   
    end
    describe "uniqueness of instance" do
      it "all instances should be unique" do
        duplicate = VaccinatedPeople.create(
          user_reference:@user_ref,
          vaccine_reference: @vaccine.reference,
          uniq_reference:@user_ref+@vaccine.reference,
          last_vaccination_date:Time.now)
        expect(duplicate).not_to be_valid
      end   
    end
    describe "uniqueness of instance" do
      it "instances could have the same vaccine_reference, if the user_reference is different" do
        false_duplicate = VaccinatedPeople.create(
          user_reference:"new_user_reference",
          vaccine_reference: @vaccine.reference,
          uniq_reference:@user_ref+@vaccine.reference,
          last_vaccination_date:Time.now)
        expect(false_duplicate).to be_valid
      end   
    end
  end
end