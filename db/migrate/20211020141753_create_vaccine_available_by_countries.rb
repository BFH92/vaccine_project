class CreateVaccineAvailableByCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccine_available_by_countries do |t|
      t.belongs_to :vaccine, null: false
      t.belongs_to :country, null: false
      t.timestamps
    end
  end
end
