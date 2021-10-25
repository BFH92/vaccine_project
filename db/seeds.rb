# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#require 'constants'

true_false=[true,false]

system("rake countries:import_csv")

VACCINE_NAMES.length.times do |i|
  vaccine = Vaccine.create!(
    name:VACCINE_NAMES[i],
    reference: VACCINE_NAMES[i].upcase.gsub(/[A,E,I,O,U,Y,\s,.,-]/,""),
    composition: COMPONENTS.sample(rand(3..8)).join(','),
    vaccine_booster_delay_in_days:rand(60..1825),
    mandatory: true || false
  )
end
@vaccines = Vaccine.all
@vaccines.length.times do 
  number_of_countries = rand(2..5)
  number_of_countries.times do 
  begin
  available_vaccine = VaccineAvailableByCountry.create!(
    country_id: rand(1..249),
    vaccine_id: rand(1..Vaccine.all.count)
  )
  rescue
    puts "error"
  end
end
end

