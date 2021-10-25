require 'rails_helper'

RSpec.describe Country, type: :request do
  before(:each) do 
    @country = Country.create(
      name:"country_test",
      reference: "VCTRY",
    )
      @admin = Admin.create(email:"admin@test.com",password:"azerty")
      
    end

  describe "GET index" do

    it "assigns @country" do
    get "/countries"
    expect(assigns(:countries)).to eq([@country])
    end
  
    it "renders the index template" do
    get "/countries"
    expect(response).to render_template("index")
    end
    
  end

  
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new country" do
        expect { 
          post "/countries", 
          params: { "country":
            { name:"country_test2",
            reference: "VCCTT23433"}}
        }.to change(Country,:count).by(1)
      end
      
      it "redirects to the new country" do
        post "/countries", params: { "country" => 
            { name:"country_test_4",
            reference: "VCCTT234333"}}
        response.should redirect_to Country.last
      end
    end
    
    context "with invalid attributes" do
      it "doest not create a new countryr" do
        expect { 
          post "/countries", params: { "country" => { name:"country 3, no attributes" } }
        }.to_not change(Country, :count)
      end
      
      it "re-renders the new method" do
        post "/countries", params: { "country" => { name:"country 3, no attributes" } }
        response.should render_template :new
      end
    end
  end
  describe 'DELETE destroy' do
  
    it "deletes the country" do
      expect{
        delete "/countries/#{@country.id}"      
      }.to change(Country, :count).by(-1)
    end
  end
end
