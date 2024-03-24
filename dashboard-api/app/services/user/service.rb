# frozen_string_literal: true
module User
  class Service
    class << self
      def get_user_data(user_id)
        User::Gateway.get_user_data(user_id)
      end
    end
  end
end
