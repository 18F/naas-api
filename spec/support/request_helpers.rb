module Request
  # helper method to generate token to use in request specs

  module AuthHelpers
    def auth_headers(user_id)
      payload = {user_id: user_id}
      payload[:exp] = 24.hours.from_now.to_i
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      {
          'Authorization': " #{token}"
      }
    end
  end
end