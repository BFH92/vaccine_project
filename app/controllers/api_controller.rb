class ApiController < ApplicationController

  def vaccines_available_by_country
    @vaccines = Vaccine.all
   @vaccines = @vaccines.first(20).map do |vaccine|
    list = []
    vaccine.countries.map do |country|
      list << country.names
    end
    vaccine.as_json.merge(countries: list)
    end
    render json: @vaccines.as_json
  end
  def update_vaccination_tracking
    @vaccines = Vaccine.all
    render json: @vaccines
  end
  
end
