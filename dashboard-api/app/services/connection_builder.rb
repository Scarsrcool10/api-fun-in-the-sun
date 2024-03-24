# frozen_string_literal: true
require 'faraday'

module ConnectionBuilder
  class << self
    def faraday_connection
      Faraday.new do |conn|
        conn.request :url_encoded
        conn.response :logger
        conn.response :json, content_type: /\bjson$/
      end
    end

    def url_builder(base_url, port, endpoint, params)
      URI("#{base_url}:" + "#{port}" + "#{endpoint}" + "#{params}")
    end
  end
end
