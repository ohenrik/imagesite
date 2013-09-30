json.array!(@photos) do |photo|
  json.extract! photo, :name, :image, :tag, :description
  json.url photo_url(photo, format: :json)
end
