class VaccinatedPeople< ApplicationRecord
  validates_uniqueness_of :user_reference, scope: [:user_reference, :vaccine_reference] 
end
