json.array!(@page_items) do |page_item|
  json.extract! page_item, :position, :page_id, :pagable_id, :pagable_type
  json.url page_item_url(page_item, format: :json)
end
