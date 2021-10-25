class VaccineAvailableByCountry < ApplicationRecord
  belongs_to :country#, optional: true
  belongs_to :vaccine#, optional: true
  validates_uniqueness_of :country_id, scope: [:country_id, :vaccine_id] 

  validates :vaccine_id, presence: true
  validates :country_id, presence: true

  @vaccines_available = VaccineAvailableByCountry.where(country_id:@country_id)



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
