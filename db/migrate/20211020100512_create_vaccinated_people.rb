class CreateVaccinatedPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccinated_people do |t|
      t.string :vaccine_reference, null: false, default: ""
      t.string :user_reference, null: false, default: ""
      t.string :uniq_reference, null: false, default: ""
      t.date :last_vaccination_date, null: false, default: Time.now.to_date

      t.timestamps
    end
  end
end
