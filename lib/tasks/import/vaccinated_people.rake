require 'csv'

namespace :vaccinated_people do
  desc "Import Vacccinated people date from CSV file"
  task import_csv: :environment do
    file_path = "#{Rails.root}/lib/data_csv/BigBoy.csv"
    file = File.read(file_path)
    table = CSV.parse(file, headers: false, col_sep:";") 
    
    puts table[0][0]
    puts table[0][1]

    puts table.length
    #table= table.to_h

  #puts "Imported #{total_count} rows, #{duplicate_count} duplicate rows where not added"
  end
end
