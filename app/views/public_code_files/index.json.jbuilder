json.array!(@public_code_files) do |public_code_file|
  json.extract! public_code_file, :public_theme_id, :name, :code, :hierarchy, :available_to, :available_in, :static_file, :display_name
  json.url public_code_file_url(public_code_file, format: :json)
end
