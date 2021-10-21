require 'csv'

@started_at = Time.current 
namespace :vaccinated_people do
  desc "Import Vacccinated people date from CSV file"
  #TODO: renaming de variables
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
      csv_rows = CSV.parse(file, headers: false, col_sep:";") 
      keys =["vaccine_reference","user_reference","last_vaccination_date"]
      all_people = csv_rows.in_groups_of(1, false)   
      list = []
      all_people.each do |people|
        people.each do |value|
          vaccinated_people_data = Hash[keys.zip(value)]
          now = Time.now
          vaccinated_people_data.store("created_at",now)
          vaccinated_people_data.store("updated_at",now)
          list << vaccinated_people_data
        end
      end
      VaccinatedPeople.upsert_all(list)#TODO: voir sur quel critères l'upsert se fait
      puts "#{list.length} vaccinated_person added to db"
    end
    rescue
      puts "oups"
    end
    import_data()
  end
  
end
