json.array!(@people) do |person|
  json.extract! person, :first_name, :last_name, :title, :description, :email, :phone, :mobile_phone, :photo_id
  json.url person_url(person, format: :json)
end
