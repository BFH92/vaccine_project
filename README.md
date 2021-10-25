# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.7.3
* Rails: 6.1.4.1
* dependencies : if you hav a problem with webpack: 
  run $bundle exec rails webpacker:install 

* initialization :
  $bundle install
  $rails db:migrate db:seed

* backoffice views :
  run $rails s  
  login/sign_up :
  As admin, you hav to sign up via devise, to have access to vaccines and countries dashboard

  

* rake task to import datas 

  run $rake vaccinated_people:import_csv  

  The program will ask the source of the csv => you must fill the file name you want to   use, corresponding to the file present in the dedicated directory.
  (~/lib/tasks/import/csv_to_import)

  Two samples are available :
    vaccinated_people.csv = 300673 unique entries on a 1 million entries dataset.(to test performance)
    test.csv = 10 unique entries on a 13 entries dataset (to handle duplicate test)
  
  You could also use your own file 
  or regenerate the vaccinated_people.csv with your parameters : 
   => modify entries_quantity,a ccording to the dataset size you want.
   => run the file with ruby (source :~/lib/tasks/import/csv_to_import/generate_vaccinated_people_csv.rb)

* RestFul_API use 
  run $rails s 

  1. List vaccines available for a country
    results are rendered by 20;
    There are two parameters  : the country reference & the number of the page, 
    please refer to the countries list generated on your db to have the correct references ! 

    example (depend on countries association created by Seed)
    method GET
    Italia, page 1 => http://localhost:3000/vaccines-list?country=ITA&page=1


  2. Mark a vaccin as injected for a member
    There are two parameters  : the user reference & the vaccine_reference.

    example (depend on your db) :
    methode POST 
    http://localhost:3000/update-tracking?&user_reference=user403&vaccine_reference=MMRVXPR

    you could pass parameters through json too.


* How to run Test : 
  1. disable/ comment the line "before_action :authenticate_admin!" on the top of vaccines & countries controller to pass all the tests 

  2. run $rspec (for all models & controllers)
  
