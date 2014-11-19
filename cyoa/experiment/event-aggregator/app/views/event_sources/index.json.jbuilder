json.array!(@event_sources) do |event_source|
  json.extract! event_source, :id, :name, :url, :frequency, :last_harvest, :json_parameters
  json.url event_source_url(event_source, format: :json)
end
