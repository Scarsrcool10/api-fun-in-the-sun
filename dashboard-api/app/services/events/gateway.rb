# frozen_string_literal: true
module Events
  class Gateway
    class << self
      def config
        YamlConfiguration.load_file("web_services", "#{Rails.env}").deep_symbolize_keys
      end

      def get_events_by_user(user_id)
        conn = ConnectionBuilder.faraday_connection
        full_url = ConnectionBuilder.url_builder(config[:events][:base_url], config[:port], config[:events][:endpoint], "?user_id=#{user_id}")
        Rails.logger.info("Establishing connection to Calendar Events service: #{conn} with url: #{full_url}")
        conn.get(full_url)
      end
    end
  end
end
