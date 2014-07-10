json.array!(@customers) do |customer|
  json.extract! customer, :first_name, :last_name, :email
  json.url customer_url(customer, format: :json)
end
