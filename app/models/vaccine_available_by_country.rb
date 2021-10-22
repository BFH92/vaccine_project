class VaccineAvailableByCountry < ApplicationRecord
  belongs_to :country, optional: true
  belongs_to :vaccine, optional: true
  #validates_uniqueness_of :country_id, scope: [:country_id, :vaccine_id] 


  @vaccines_available = VaccineAvailableByCountry.where(country_id:@country_id)

  def countries_of(vaccine)
    @countries = Country.all
    list = []
    vaccine.countries.ids.map do |country|  
    list << @countries.find(country).name
    end
    list.join(",")
  end

  def create_custom_infos(list,user_ref)
  hash ={}
      vaccine = Vaccine.find(self.vaccine_id)
      vaccine.add_global_infos(hash,self)
      if user_ref
        vaccine.add_user_injections_infos(user_ref,hash)
      end
    list << hash
  end
  
end
