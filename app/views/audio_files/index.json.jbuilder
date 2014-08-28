json.array!(@media_files) do |media_file|
  json.extract! media_file, :id, :title, :description
  json.url media_file_url(media_file, format: :json)
end
