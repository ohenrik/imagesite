json.array!(@offers) do |offer|
  json.extract! offer, :name, :price, :currency, :capacity, :offerable_id, :offerable_type
  json.url offer_url(offer, format: :json)
end
