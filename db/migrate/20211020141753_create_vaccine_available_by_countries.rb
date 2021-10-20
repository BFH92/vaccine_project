class CreateVaccineAvailableByCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccine_available_by_countries do |t|
      t.belongs_to :vaccine
      t.belongs_to :country
      t.timestamps
    end
  end
end
