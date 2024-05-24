# frozen_string_literal: true
module Subscriptions
  class Service
    class << self
      def get_user_subscription_details(user_id)
        Subscriptions::Gateway.get_user_subscription_details(user_id)
      end
    end
  end
end
