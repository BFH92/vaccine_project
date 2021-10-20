class Vaccine < ApplicationRecord
  has_many :vaccine_available_by_countries
  has_many :countries, through: :vaccine_available_by_countries
end
