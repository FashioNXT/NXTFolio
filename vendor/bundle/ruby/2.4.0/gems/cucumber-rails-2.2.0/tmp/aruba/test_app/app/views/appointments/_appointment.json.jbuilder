json.extract! appointment, :id, :name, :when, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
