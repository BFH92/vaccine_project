require 'csv'

@started_at = Time.current 
namespace :vaccinated_people do
  desc "Import Vacccinated people date from CSV file"
  task import_csv: :environment do
    def import_data
    input = ''
    STDOUT.puts "IMPORT VACCINATED PEOPLE FROM CSV TO DB"
    STDOUT.puts "What file do you want to import from '~tasks/import/csv_to_import' directory? "
    input = STDIN.gets.chomp
    file_path = (File.dirname(__FILE__) + "/csv_to_import/#{input}")  
    begin
      file = File.read(file_path)
    rescue
      STDOUT.puts "No such file in '~tasks/import/csv_to_import' named '#{input}'' !"
      STDOUT.puts "RESTARTING.."
      import_data()
      exit
    end
    begin
      started_time = Time.now
      puts "Started at #{started_time}"
      puts "retrieve data from DB ..."
      csv_rows = CSV.parse(file, headers: false, col_sep:";") 
      keys =["vaccine_reference","user_reference","last_vaccination_date"]
      all_people = csv_rows.in_groups_of(1, false)   
      list = []
      already_vaccinated_people = VaccinatedPeople.all
      already_vaccinated_people.each do |data|
        uniq_ref = data["vaccine_reference"]+data["user_reference"]
        a = Hash.new
        a.store(:vaccine_reference, data["vaccine_reference"])
        a.store(:user_reference, data["user_reference"])
        a.store(:last_vaccination_date, data["last_vaccination_date"])
        a.store(:uniq_reference, uniq_ref)
        a.store(:created_at,data["created_at"])
        a.store(:updated_at,data["updated_at"])
        list<< a
      end
      
      puts "add csv to list ..."
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
      list.uniq!{ |p| p[:uniq_reference] }
      VaccinatedPeople.delete_all
      VaccinatedPeople.upsert_all(list)
      puts "add #{list.length} entries to DB via rake time = #{Time.now - started_time} seconds"
    end
  rescue
  end
    import_data()
  end
  
end
