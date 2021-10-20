json.extract! vaccine, :id, :name, :reference, :composition, :vaccine_booster_delay_in_days, :mandatory, :available_country, :created_at, :updated_at
json.url vaccine_url(vaccine, format: :json)
