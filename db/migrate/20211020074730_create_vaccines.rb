class CreateVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines do |t|
      t.string :name
      t.string :reference
      t.text :composition
      t.integer :vaccine_booster_delay_in_days
      t.boolean :mandatory
      t.text :available_country

      t.timestamps
    end
  end
end
