class VaccinatedPeopleController < ApiController
  before_action :set_vaccinated_person, only: %i[ show update destroy ]

  def index
    @vaccinated_people = VaccinatedPerson.all
  end

  def show
  end

  def create
    @vaccinated_person = VaccinatedPerson.new(vaccinated_person_params)

    if @vaccinated_person.save
      render json: @vaccinated_person, status: :created, location: @vaccinated_person
    else
      render json: @vaccinated_person.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vaccinated_person.update(vaccinated_person_params)
      render :show, status: :ok, location: @vaccinated_person
    else
      render json: @vaccinated_person.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccinated_person.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccinated_person
      @vaccinated_person = VaccinatedPerson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vaccinated_person_params
      params.require(:vaccinated_person).permit(:vaccine_reference, :user_reference, :last_vaccination_date)
    end
end
