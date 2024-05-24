require 'uri'
require 'net/http'

class SummaryController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def show
    @user_id = params[:user_id]
    @user_details = get_user_data(@user_id).body.deep_symbolize_keys
    @subscription_details = calculate_sub_details
    @past_events = parse_past_events
    @future_events = parse_future_events
    render formats: :json
  end

  private

  def get_user_data(user_id)
    User::Service.get_user_data(user_id)
  end

  def get_user_subscription_details(user_id)
    Subscriptions::Service.get_user_subscription_details(user_id)
  end

  def get_events_by_user(user_id)
    Events::Service.get_events_by_user(user_id)
  end

  def calculate_sub_details
    sub_details = get_user_subscription_details(@user_id).body.deep_symbolize_keys
    start_date = Date.strptime(sub_details[:renewal_date], "%m/%d/%Y")
    end_date = DateTime.now
    days_remaining = (start_date - end_date).to_i

    {
      renewal_date: sub_details[:renewal_date],
      days_until_renewal: days_remaining,
      subscription_cost: number_to_currency(sub_details[:price_cents] / 100.0),
      pricing_plan: sub_details[:plan]
    }
  end

  def parse_raw_event_data
    get_events_by_user(@user_id).body.deep_symbolize_keys[:events]
  end

  def parse_past_events
    past_events = parse_raw_event_data.reject{ |event| time_variance(event[:date]) < 0 }
    {
      number_of_past_meetings:  past_events.count
    }
  end

  def parse_future_events
    parse_raw_event_data.reject{ |event| time_variance(event[:date]) > 0 }
  end

  def time_variance(date_time)
    (DateTime.now - DateTime.strptime(date_time, "%m/%d/%Y, %I:%M:%S %p")).to_i
  end
end
