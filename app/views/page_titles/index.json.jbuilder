json.array!(@page_titles) do |page_title|
  json.extract! page_title, :title
  json.url page_title_url(page_title, format: :json)
end
