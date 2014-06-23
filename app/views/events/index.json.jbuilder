json.array!(@events) do |event|
  json.extract! event, :name, :description, :location, :start_date, :end_date, :start_time, :end_time, :photo_id
  json.url event_url(event, format: :json)
end
