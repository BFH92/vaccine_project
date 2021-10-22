class CountriesController < ApplicationController
  before_action :set_country, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!
  
  def index
    @countries = Country.all
  end

  def show
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: "Country was successfully created." }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: "Country was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :reference)
    end
end
