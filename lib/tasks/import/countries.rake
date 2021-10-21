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
    tables.each do |values|
      values.each do |i|
      value = Hash[keys.zip(i)]
      now = Time.now
      value.store("created_at",now.to_s)
      value.store("updated_at",now.to_s)
      array << value

    end
    
  end
    Country.insert_all(array)
end
end
