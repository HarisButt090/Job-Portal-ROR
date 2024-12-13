class Mutations::UserLogout < Mutations::BaseMutation
  field :message, String, null: false

  def resolve
    raise GraphQL::ExecutionError, "Not authenticated" if context[:current_user].nil?

    header = context[:request].headers['Authorization']
    binding.pry
    token = header&.split(' ')&.last
    binding.pry
    if token
      begin
        payload = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256').first
        binding.pry
        jti = payload['jti']
        binding.pry

        JwtDenylist.create!(jti: jti, exp: Time.at(payload['exp']))
      rescue JWT::DecodeError
        raise GraphQL::ExecutionError, "Invalid token"
      end
    else
      raise GraphQL::ExecutionError, "No token provided"
    end

    { message: 'Logout successful' }
  end
end
