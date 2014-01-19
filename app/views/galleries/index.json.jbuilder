json.array!(@galleries) do |gallery|
  json.extract! gallery, :title, :subtitle, :description, :gallery_type
  json.url gallery_url(gallery, format: :json)
end
