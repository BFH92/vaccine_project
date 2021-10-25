require 'rails_helper'

RSpec.describe Vaccine, type: :request do
  before(:each) do 
    @vaccine = Vaccine.create(
      name:"vaccine_test",
      reference: "VCCTT234",
      composition: "aceticacide,Chloroplatinic acid",
      vaccine_booster_delay_in_days:90,
      mandatory: true)
      @admin = Admin.create(email:"admin@test.com",password:"azerty")
      
    end

  describe "GET index", :type => :request do

    it "assigns @vaccine" do
    get "/vaccines"
    expect(assigns(:vaccines)).to eq([@vaccine])
    end
  
    it "renders the index template" do
    get "/vaccines"
    expect(response).to render_template("index")
    end
    
  end

  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new vaccine" do
        expect { 
          post "/vaccines", 
          params: { "vaccine":
            { name:"vaccine_test_2",
            reference: "VCCTT23433",
            composition: "aceticacide,Chloroplatinic acid",
            vaccine_booster_delay_in_days:120,
            mandatory: 1 }}
        }.to change(Vaccine,:count).by(1)
      end
      
      it "redirects to the new vaccine" do
        post "/vaccines", params: { "vaccine" => 
            { name:"vaccine_test_4",
            reference: "VCCTT234333",
            composition: "aceticacide,Chloroplatinic acid",
            vaccine_booster_delay_in_days:120,
            mandatory: 1}}
        response.should redirect_to Vaccine.last
      end
    end
    
    context "with invalid attributes" do
      it "doest not create a new vacciner" do
        expect { 
          post "/vaccines", params: { "vaccine" => { name:"vaccine 3, no attributes" } }
        }.to_not change(Vaccine, :count)
      end
      
      it "re-renders the new method" do
        post "/vaccines", params: { "vaccine" => { name:"vaccine 3, no attributes" } }
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do
  context "with valid attributes" do
     new_composition = "new composition"
    it "changes @user's attributes" do    
      put "/vaccines/#{@vaccine.id}", params: { 
        "vaccine" =>
        {name:"vaccine_test_updated",
        reference: "VCCTT234333",
        composition: "new composition",
        vaccine_booster_delay_in_days:120,
        mandatory: 1} } 
      @vaccine.reload
      @vaccine.composition.should eq("new composition")
    end
  end
  
    context "with invalid attributes" do
      it "does not change @vaccine's attributes" do
        invalid_attribute = "fake"
        patch "/vaccines/#{@vaccine.id}", params: { "vaccine" => { mandatory: invalid_attribute } }
        @vaccine.reload
        @vaccine.mandatory.should_not eq(invalid_attribute)
      end
    end
  end
  describe 'DELETE destroy' do
  
    it "deletes the vaccine" do
      expect{
        delete "/vaccines/#{@vaccine.id}"      
      }.to change(Vaccine, :count).by(-1)
    end
  end
end
