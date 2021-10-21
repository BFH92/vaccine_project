class ApiController < ApplicationController
  before_action :set_user,:set_country_id,:set_vaccine

  def get_vaccines_datas_by_country_and_user
    @list= []
    @vaccines_available = VaccineAvailableByCountry.where(country_id:@country_id)
    @vaccines_available.map do |vaccine_available|
      vaccine_available.create_custom_infos(@list,@user_ref)
    end
    @sorted_list = []
    sort_list(@list, @sorted_list)
    render json:@sorted_list
  end

  def update_vaccination_tracking
    @new_data= VaccinatedPeople.find_by(user_reference:@user_ref,vaccine_reference: @vaccine_ref)
     @new_data.nil? ? 
     @new_data = VaccinatedPeople.create(tracking_params) 
     : @new_data.update(tracking_params)
    render json: @new_data
  end

  private 
  def tracking_params
    defaults = {:last_vaccination_date =>Time.now.to_date}
    params.permit(:user_reference,:vaccine_reference,:last_vaccination_date).reverse_merge(defaults)
  end
  def set_country_id
    @country_reference = params[:country]
    @country_id = Country.find_by(reference:@country_reference)
  end
  def set_user
    @user_ref = params[:user_reference]
  end
  def set_vaccine
    @vaccine_ref = params[:vaccine_reference]
  end
end
