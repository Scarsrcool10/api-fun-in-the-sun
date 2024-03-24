# frozen_string_literal: true
module Subscriptions
  class Gateway
    class << self
      def config
        YamlConfiguration.load_file("web_services", "#{Rails.env}").deep_symbolize_keys
      end

      def get_user_subscription_details(user_id)
        conn = ConnectionBuilder.faraday_connection
        full_url = ConnectionBuilder.url_builder(config[:subscriptions][:base_url], config[:port], config[:subscriptions][:endpoint], "?user_id=#{user_id}")
        Rails.logger.info("Establishing connection to Subscription service: #{conn} with url: #{full_url}")
        conn.get(full_url)
      end
    end
  end
end
