class ApiController < ApplicationController

  def vaccines_available_by_country
    @vaccines = Vaccine.all
    render json: @vaccines
  end
  def update_vaccination_tracking
    @vaccines = Vaccine.all
    render json: @vaccines
  end
  
end
