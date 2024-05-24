# frozen_string_literal: true
json.user_summary_data do
  json.partial! 'user_details', locals: { user_details: @user_details }

  json.extract! @past_events, :number_of_past_meetings

  json.future_calendar_events do
    json.partial! 'calendar_events', locals: { future_events: @future_events }
  end

  json.subscription_data do
    json.partial! 'subscription_details', locals: { subscription_details: @subscription_details }
  end
end
