json.extract! vaccinated_person, :id, :vaccine_reference, :user_reference, :last_vaccination_date, :created_at, :updated_at
json.url vaccinated_person_url(vaccinated_person, format: :json)
