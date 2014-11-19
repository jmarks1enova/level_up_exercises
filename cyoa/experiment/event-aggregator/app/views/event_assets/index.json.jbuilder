json.array!(@event_assets) do |event_asset|
  json.extract! event_asset, :id, :calendar_event_id, :caption, :mime_type, :data
  json.url event_asset_url(event_asset, format: :json)
end
