class Country < ApplicationRecord
  has_many :vaccine_available_by_countries
  has_many :vaccines, through: :vaccine_available_by_countries
  validates_uniqueness_of :name, scope: [:name, :reference] 
  validates :name, presence: true
  validates :reference, presence: true

end
