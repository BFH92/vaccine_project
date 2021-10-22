class ApiController < ApplicationController
  before_action :set_user,:set_country_id,:set_vaccine,:set_pagination

  def get_vaccines_datas_by_country_and_user
    @list= []
    @vaccines_available = VaccineAvailableByCountry
    .where(country_id:@country_id)
    .offset(@pagination_starting)
    .limit(@results_by_page)

    @vaccines_available.map do |vaccine_available|
      vaccine_available.create_custom_infos(@list,@user_ref)
    end
    @sorted_list = []
    sort_list(@list, @sorted_list)
    render json:@sorted_list
  end

  def update_vaccination_tracking
    @new_data= VaccinatedPeople.where(user_reference:@user_ref,vaccine_reference: @vaccine_ref).last
     @new_data.nil? ? 
     @new_data = VaccinatedPeople.create(tracking_params) : @new_data.update(tracking_params)
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
  def set_pagination
    page = params[:page].to_i || 1
    @results_by_page = 100
    @pagination_starting = (page - 1) * @results_by_page
  end

  def sort_list(list, sorted_list)
    list.select{|x| x["mandatory"] == "yes" && x["last_injection_date"] == nil}.map do |hash|
      sorted_list << hash
    end
    list.select{|x| x["mandatory"] == "no" && x["last_injection_date"] == nil}.map do |hash|
      sorted_list << hash
    end
    list.select{|x| x["last_injection_date"] != nil}.map do |hash|
      sorted_list << hash
    end
  end
end
