json.extract! vaccinated_people, :id, :vaccine_reference, :user_reference, :last_vaccination_date, :created_at, :updated_at
json.url vaccinated_people_url(vaccinated_people, format: :json)
