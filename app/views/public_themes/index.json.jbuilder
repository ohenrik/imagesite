json.array!(@public_themes) do |public_theme|
  json.extract! public_theme, :name, :zip
  json.url public_theme_url(public_theme, format: :json)
end
