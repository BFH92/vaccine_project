require 'csv'

namespace :countries do
  desc "IMPORT COUNTRIES DATA"
  task import_csv: :environment do
    
      def config_csv
        file_path = (File.dirname(__FILE__) + "/csv_to_import/countries.csv")  
        @file = File.read(file_path)
        return @file
      end
      def add_existing_countries_to(list)
        existing_countries = Country.all
        existing_countries.each do |data|
          hash = Hash.new
          hash.store(:created_at,data["created_at"])
          hash.store(:updated_at,data["updated_at"])
          hash.store(:name, data["name"])
          hash.store(:reference, data["reference"])
          list << hash
        end
      end
      def add_new_countries_to(list)
        puts "add csv to list"
        csv_rows = CSV.parse(@file, headers: false, col_sep:";") 
        new_countries = csv_rows.in_groups_of(1, false)   
        keys =[:name,:reference]
        new_countries.each do |country|  
          country.each do |info|
            now = Time.now
            value = Hash[keys.zip(info)]
            value.store(:created_at,now)
            value.store(:updated_at,now)
            #puts info
            list << value
          end
        end
      
      end
      def add_countries_to_db_from(list)
        list.uniq!{ |p| p[:name] }
        Country.delete_all
        Country.upsert_all(list)
      end
      def import_data
        list = []
        config_csv()
        add_existing_countries_to(list)
        add_new_countries_to(list)
        add_countries_to_db_from(list)
        puts "#{list.length} countries added to db"
      end
      import_data()
  end
end

