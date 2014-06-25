json.array!(@productions) do |production|
  json.extract! production, :name, :description, :photo_id
  json.url production_url(production, format: :json)
end
