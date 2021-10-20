class Country < ApplicationRecord
  has_many :vaccines, through: :vaccine_available_by_countries
end
