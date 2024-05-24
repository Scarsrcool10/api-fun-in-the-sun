# frozen_string_literal: true
module Events
  class Service
    class << self
      def get_events_by_user(user_id)
        Events::Gateway.get_events_by_user(user_id)
      end
    end
  end
end
