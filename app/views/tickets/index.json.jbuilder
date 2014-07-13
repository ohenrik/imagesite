json.array!(@tickets) do |ticket|
  json.extract! ticket, :name, :price, :currency, :offer_id, :customer_id
  json.url ticket_url(ticket, format: :json)
end
