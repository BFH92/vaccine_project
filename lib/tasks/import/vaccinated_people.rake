require 'csv'

@started_at = Time.current 
namespace :vaccinated_people do
  desc "Import Vacccinated people date from CSV file"
  task import_csv: :environment do
    def config_csv
      input = ''
      STDOUT.puts "IMPORT VACCINATED PEOPLE FROM CSV TO DB"
      STDOUT.puts "What file do you want to import from '~tasks/import/csv_to_import' directory? "
      input = STDIN.gets.chomp
      @file_path = (File.dirname(__FILE__) + "/csv_to_import/#{input}")  
      begin
        @file = File.read(@file_path)
        return @file
      rescue
        STDOUT.puts "No such file in '~tasks/import/csv_to_import' named '#{input}'' !"
        STDOUT.puts "RESTARTING.."
        config_csv()
      end
    end
    
    def retrieve_data_from_db_to(list)
      @started_time = Time.now
      puts "Started at #{@started_time}"
      puts "retrieve data from DB ..."
      already_vaccinated_people = VaccinatedPeople.all
      already_vaccinated_people.each do |data|
        uniq_ref = data["vaccine_reference"]+data["user_reference"]
        vaccinated_people_data = Hash.new
        vaccinated_people_data.store(:vaccine_reference, data["vaccine_reference"])
        vaccinated_people_data.store(:user_reference, data["user_reference"])
        vaccinated_people_data.store(:last_vaccination_date, data["last_vaccination_date"])
        vaccinated_people_data.store(:uniq_reference, uniq_ref)
        vaccinated_people_data.store(:created_at,data["created_at"])
        vaccinated_people_data.store(:updated_at,data["updated_at"])
        list << vaccinated_people_data
      end
    end
    
    def add_csv_to(list)
      puts "add csv to list ..."
      keys =["vaccine_reference","user_reference","last_vaccination_date"]
      csv_rows = CSV.parse(@file, headers: false, col_sep:";") 
      all_people = csv_rows.in_groups_of(1, false)   
        all_people.each do |people|
          people.each do |value|
            now = Time.now
            vaccinated_people_data = Hash[keys.zip(value)]
            uniq_ref = vaccinated_people_data["vaccine_reference"]+vaccinated_people_data["user_reference"]
            vaccinated_people_data.store(:uniq_reference,uniq_ref)
            vaccinated_people_data.store(:created_at,now)
            vaccinated_people_data.store(:updated_at,now)
            list << vaccinated_people_data
          end
        end
    end
    def insert_data_to_db_from(list)
      list.uniq!{ |p| p[:uniq_reference] }
      VaccinatedPeople.delete_all
      VaccinatedPeople.upsert_all(list)
    end
    def import_data
      list = []
      config_csv()
      retrieve_data_from_db_to(list)
      list_csv_data_excluded = list.length
      add_csv_to(list)
      insert_data_to_db_from(list)
      puts "add new #{list.length - list_csv_data_excluded} entries to DB on existing #{list.length} entries, via rake | time = #{Time.now - @started_time} seconds"
    end
    import_data()
  end  
end
  

