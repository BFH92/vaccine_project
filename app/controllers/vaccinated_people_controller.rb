class VaccinatedPeopleController < ApiController
  before_action :set_vaccinated_people, only: %i[update destroy ]

  def create
    @vaccinated_people = VaccinatedPeople.new(vaccinated_people_params)
    if @vaccinated_people.save
      render json: @vaccinated_people, status: :created, location: @vaccinated_people
    else
      render json: @vaccinated_people.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vaccinated_people.update(vaccinated_people_params)
      render :show, status: :ok, location: @vaccinated_people
    else
      render json: @vaccinated_people.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccinated_people.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccinated_people
      @vaccinated_people = VaccinatedPeople.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vaccinated_people_params
      params.require(:vaccinated_people).permit(:vaccine_reference, :user_reference, :last_vaccination_date,:uniq_reference)
    end
end
