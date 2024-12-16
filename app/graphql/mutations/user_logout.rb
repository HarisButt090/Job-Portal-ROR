class Mutations::UserLogout < Mutations::BaseMutation
  field :message, String, null: false

  def resolve
    # Check if the user is authenticated
    raise GraphQL::ExecutionError, "Not authenticated" if context[:current_user].nil?

    # Extract the Authorization header
    header = context[:request].headers['Authorization']
    binding.pry
    token = header&.split(' ')&.last
    binding.pry

    # Handle missing token
    raise GraphQL::ExecutionError, "No token provided" if token.nil?

    begin
      # Decode the JWT token
      payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
      binding.pry

      # Extract the `jti` (JWT ID) from the payload
      jti = payload['jti']
      binding.pry

      exp = payload['exp']
      binding.pry

      # Ensure `exp` is present and valid
      raise GraphQL::ExecutionError, "Invalid token payload: missing 'exp'" if exp.nil?

      # Create an entry in the JwtDenylist
      JwtDenylist.create!(jti: jti, exp: Time.at(exp))

      # Return a successful logout message
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
