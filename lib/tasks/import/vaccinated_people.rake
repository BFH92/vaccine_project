require 'csv'
@started_at = Time.current 
namespace :vaccinated_people do
  desc "Import Vacccinated people date from CSV file"
  
  task import_csv: :environment do
    file_path = "#{Rails.root}/lib/data_csv/vaccinated_people.csv"
    file = File.read(file_path)
    table = CSV.parse(file, headers: false, col_sep:";") 
    keys =["vaccine_reference","user_reference","last_vaccination_date"]
    tables = table.in_groups_of(1, false)   
    array = []
    tables.each do |values|
    values.each do |i|
    value = Hash[keys.zip(i)]
    now = Time.now
    value.store("created_at",now.to_s)
    value.store("updated_at",now.to_s)
    array << value
    #puts value
    end
    puts array.length
    
  end
    VaccinatedPerson.insert_all(array)
  
    puts table.length
  end

end
