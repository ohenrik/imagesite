json.array!(@themes) do |theme|
  json.extract! theme, :name, :zip
  json.url theme_url(theme, format: :json)
end
