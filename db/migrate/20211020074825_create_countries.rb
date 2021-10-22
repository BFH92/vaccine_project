class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false, default: 0
      t.string :reference, null: false, default: 0

      t.timestamps
    end
  end
end
