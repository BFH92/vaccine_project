class VaccineAvailableByCountry < ApplicationRecord
  belongs_to :country
  belongs_to :vaccine
end
