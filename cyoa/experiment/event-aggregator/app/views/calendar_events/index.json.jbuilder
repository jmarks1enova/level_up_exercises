json.array!(@calendar_events) do |calendar_event|
  json.extract! calendar_event, :id, :id, :title, :start_time, :end_time, :datetime, :description
  json.url calendar_event_url(calendar_event, format: :json)
end
