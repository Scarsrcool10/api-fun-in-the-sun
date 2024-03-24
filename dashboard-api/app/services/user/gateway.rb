# frozen_string_literal: true
require "faraday"

module User
  class Gateway
    class << self
      def config
        YamlConfiguration.load_file("web_services", "#{Rails.env}").deep_symbolize_keys
      end

      def get_user_data(user_id)
        conn = ConnectionBuilder.faraday_connection
        full_url = ConnectionBuilder.url_builder(config[:user_service][:base_url], config[:port], config[:user_service][:endpoint], "/#{user_id}")
        Rails.logger.info("Establishing connection to User service: #{conn} with url: #{full_url}")
        conn.get(full_url)
      end
    end
  end
end

