class Country < ApplicationRecord
  has_many :vaccines, through: :vaccine_available_by_countries
  validates_uniqueness_of :name, scope: [:name, :reference] 
end
