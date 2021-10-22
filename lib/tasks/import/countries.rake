require 'csv'

namespace :countries do
  desc "IMPORT COUNTRIES DATA"
  task import_csv: :environment do
    file_path = "#{Rails.root}/lib/data_csv/countries.csv"
    file = File.read(file_path)
    table = CSV.parse(file, headers: false, col_sep:";") 

    keys =["name","reference"]
    tables = table.in_groups_of(1, false)   
    array = []
    already_vaccinated_people = Country.all
    already_vaccinated_people_json = already_vaccinated_people.as_json
    already_vaccinated_people_json.each do |data|
      {
        "name": data["name"],
        "reference": data["reference"]
      }
    end
  
  
    tables.each do |values|  
      values.each do |i|
        now = Time.now
      value = Hash[keys.zip(i)]
      array << value
    end

  end

  array = array.inject([]) { |result,h| result << h unless result.include?(h); result }

  array.each do |value|
    now = Time.now
    
    value.store("created_at",now.to_s)
    value.store("updated_at",now.to_s)
  end
Country.destroy_all
Country.upsert_all(array)
  
end
end
