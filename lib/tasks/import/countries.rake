require 'csv'

namespace :countries do
  desc "IMPORT COUNTRIES DATA"
  task import_csv: :environment do
    file_path = "#{Rails.root}/lib/data_csv/countries.csv"
    file = File.read(file_path)
    table = CSV.parse(file, headers: false, col_sep:";") 
    
    puts table[0][0]
    puts table[0][1]

    puts table.length
    table= table.to_h
    table.for
  #puts "Imported #{total_count} rows, #{duplicate_count} duplicate rows where not added"
  end
end
