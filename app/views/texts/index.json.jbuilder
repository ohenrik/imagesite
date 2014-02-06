json.array!(@texts) do |text|
  json.extract! text, :content
  json.url text_url(text, format: :json)
end
