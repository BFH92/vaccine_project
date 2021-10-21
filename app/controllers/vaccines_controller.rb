class VaccinesController < ApplicationController
  before_action :set_vaccine, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!
  def index
    @vaccines = Vaccine.all
    @countries = Country.all
  end

  def show
    @countries = Country.all
  end

  def new
    @vaccine = Vaccine.new
  end

  def edit
    @countries = Country.all
    @vaccine_id = params[:id]
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
    
    @vaccine_id = params[:id]
    @countries_where_vaccine_is_available = VaccineAvailableByCountry.where(vaccine_id:@vaccine_id)
    @countries_registered = params[:country]
    @new_tags = params[:new_tag]
    respond_to do |format|
      if @vaccine.update(vaccine_params)
        format.html { redirect_to @vaccine, notice: "Vaccine was successfully updated." }
        format.json { render :show, status: :ok, location: @vaccine }
        @vaccine.update_countries(@countries_where_vaccine_is_available,@vaccine_id,@countries_registered)
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
      @vaccine = Vaccine.find(params[:id])
    end

    def vaccine_params
      params.require(:vaccine).permit(:name, :reference, :composition, :vaccine_booster_delay_in_days, :mandatory, :available_country)
    end
end
