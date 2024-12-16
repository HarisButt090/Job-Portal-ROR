class Mutations::UserLogout < Mutations::BaseMutation
  field :message, String, null: false

  def resolve
    raise GraphQL::ExecutionError, "Not authenticated" if context[:current_user].nil?

    header = context[:request].headers['Authorization']
    token = header&.split(' ')&.last
    raise GraphQL::ExecutionError, "No token provided" if token.nil?

    begin
      payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
      jti = payload['jti']
      exp = payload['exp']
      JwtDenylist.create!(jti: jti, exp: Time.at(exp))

      { message: 'Logout successful' }
    rescue JWT::DecodeError
      raise GraphQL::ExecutionError, "Invalid token"
    rescue ActiveRecord::RecordInvalid => e
      raise GraphQL::ExecutionError, "Logout failed: #{e.message}"
    rescue => e
      Rails.logger.error("UserLogout Error: #{e.message}")
      raise GraphQL::ExecutionError, "An unexpected error occurred"
    end
  end
end
