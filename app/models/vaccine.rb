class Vaccine < ApplicationRecord
  has_many :vaccine_available_by_countries
  has_many :countries, through: :vaccine_available_by_countries
  validates_uniqueness_of :name, scope: [:name, :reference] 
  
  def update_countries(countries_where_vaccine_is_available,vaccine_id,countries)
    countries_where_vaccine_is_available.each do |country_available_in|
      if !(country_available_in.vaccine_id ==  vaccine_id && countries != nil ? @countries.include?(country_available_in.vaccine_id): false)
        country_available_in.destroy
      end
    end
    if countries != nil 
      countries.each do |country|
        VaccineAvailableByCountry.create!(vaccine_id: vaccine_id, country_id: country.to_i)
      end
    end
  end

  def add_global_infos(hash, vaccine_available)
    hash.store("reference",self.reference)
    hash.store("name",self.name)
    hash.store("composition",self.composition)
    self.mandatory ? hash.store("mandatory","yes") : hash.store("mandatory","no")
    countries = VaccineAvailableByCountry.where(vaccine_id: self.id)
    hash.store("available_countries", vaccine_available.countries_of(self))
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
