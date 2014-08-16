json.array!(@audio_files) do |audio_file|
  json.extract! audio_file, :id, :title, :description
  json.url audio_file_url(audio_file, format: :json)
end
