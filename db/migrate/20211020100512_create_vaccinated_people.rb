class CreateVaccinatedPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccinated_people do |t|
      t.string :vaccine_reference
      t.string :user_reference
      t.date :last_vaccination_date

      t.timestamps
    end
  end
end
