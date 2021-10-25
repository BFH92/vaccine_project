class Vaccine < ApplicationRecord
  has_many :vaccine_available_by_countries, dependent: :destroy
  has_many :countries, through: :vaccine_available_by_countries
  validates :name, presence: true
  validates :reference, presence: true
  validates :composition, presence: true
  validates :vaccine_booster_delay_in_days, presence: true
  validates :mandatory, presence: true
  validates_uniqueness_of :name, scope: [:name, :reference] 


  def update_countries(countries_where_vaccine_is_available,countries)
    #if countries_where_vaccine_is_available != nil 
    countries_where_vaccine_is_available.each do |country_available_in|
        if !(country_available_in.vaccine_id == self.id && countries != nil ? countries.include?(country_available_in.vaccine_id): false)
          country_available_in.destroy
        end
      end
  #  end
    if countries != nil 
      countries.each do |country|
        VaccineAvailableByCountry.create!(vaccine_id: self.id, country_id: country.to_i)
      end
    end
  
  end

  def add_global_infos(hash, vaccine_available)
    hash.store("reference",self.reference)
    hash.store("name",self.name)
    hash.store("composition",self.composition)
    self.mandatory ? hash.store("mandatory","yes") : hash.store("mandatory","no")
    countries = VaccineAvailableByCountry.where(vaccine_id: self.id)
    hash.store("available_countries", self.get_countries_names)
    
  end
  def get_countries_names
    @countries = Country.all
    list = []
    self.countries.ids.map do |country|  
    list << @countries.find(country).name
    end
    list.join(",")
    return list
  end

  def add_user_injections_infos(user_ref,hash)
    user_injection = VaccinatedPeople.find_by(user_reference:user_ref, vaccine_reference: self.reference)
    if !user_injection.nil?
    hash.store("delay",self.vaccine_booster_delay_in_days)
    user_last_injection = user_injection.last_vaccination_date 
    booster_delay = self.vaccine_booster_delay_in_days
    next_booster_date = user_last_injection + booster_delay
    hash.store("last_injection_date",user_last_injection)
    hash.store("next_booster_date",next_booster_date)
    end
  end
end
