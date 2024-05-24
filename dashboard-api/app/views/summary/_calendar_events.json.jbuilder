json.array! @future_events do |hash|
  json.extract! hash, :name, :date, :duration, :attendees
end
