class VaccinatedPeople< ApplicationRecord
  validates_uniqueness_of :user_reference, scope: [:user_reference, :vaccine_reference]
  validates :user_reference, presence: true 
  validates :vaccine_reference, presence: true 
  validates :uniq_reference, presence: true 
end
