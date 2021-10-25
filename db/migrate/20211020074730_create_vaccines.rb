class CreateVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines do |t|
      t.string :name, null: false, default: ""
      t.string :reference, null: false, default: ""
      t.text :composition, null: false, default: ""
      t.integer :vaccine_booster_delay_in_days, null: false
      t.boolean :mandatory, null: false

      t.timestamps
    end
  end
end
