json.array!(@line_items) do |line_item|
  json.extract! line_item, :cart_id, :offer_id
  json.url line_item_url(line_item, format: :json)
end
