class VaccinesController < ApplicationController
  before_action :set_vaccine, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!
  before_action :set_countries
  before_action :set_pagination
  def index
    @vaccines = Vaccine.all.offset(@pagination_starting).limit(@results_by_page)
  end

  def show
  end

  def new
    @vaccine = Vaccine.new
  end

  def edit
    @vaccines_available_by_country = VaccineAvailableByCountry.all
  end

  def create
    @vaccine = Vaccine.new(vaccine_params)
    respond_to do |format|
      if @vaccine.save
        format.html { redirect_to @vaccine, notice: "Vaccine was successfully created." }
        format.json { render :show, status: :created, location: @vaccine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    @countries_where_vaccine_is_already_available = VaccineAvailableByCountry.where(vaccine_id:@vaccine_id)
    @countries_updated = params[:country]
    respond_to do |format|
      if @vaccine.update(vaccine_params)
        format.html { redirect_to @vaccine, notice: "Vaccine was successfully updated." }
        format.json { render :show, status: :ok, location: @vaccine }
        @vaccine.update_countries(@countries_where_vaccine_is_already_available,@countries_updated)
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vaccine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vaccine.destroy
    respond_to do |format|
      format.html { redirect_to vaccines_url, notice: "Vaccine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_vaccine
      @vaccine_id = params[:id]
      @vaccine = Vaccine.find(@vaccine_id)
      
    end
    def set_countries
      @countries = Country.all
    end
    def set_pagination
      @vaccines_all = Vaccine.all.count
      @page =  params[:page].nil? ? 1 : params[:page].to_i 
      @results_by_page = 20
      @pagination_starting = (@page - 1) * @results_by_page
      @previous_page = @page > 1? @page-1 : @page
      @next_page = @page <= @vaccines_all/@results_by_page ? @page+1 : @page
    end  
    def vaccine_params
      params.require(:vaccine).permit(:name, :reference, :composition, :vaccine_booster_delay_in_days, :mandatory, :available_country)
    end
end
