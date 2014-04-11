json.array!(@code_files) do |code_file|
  json.extract! code_file, :theme_id, :name, :code, :hierarchy
  json.url code_file_url(code_file, format: :json)
end
