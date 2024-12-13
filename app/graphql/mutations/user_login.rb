class Mutations::UserLogin < Mutations::BaseMutation
  argument :login_attributes, Types::LoginAttributes, required: true

  # Returning token, message, and user fields
  field :token, String, null: true
  field :message, String, null: true
  field :user, Types::User::UserType, null: true

  def resolve(login_attributes:)
    email = login_attributes[:email]
    password = login_attributes[:password]

    user = User.find_by(email: email)

    if user&.valid_password?(password)
      # Use Rails' secret_key_base to generate the token
      payload = { sub: user.id, name: user.name }
      token = JWT.encode(payload, Rails.application.secret_key_base, 'HS256') # Use the same secret key for encoding

      {
        token: token,
        message: 'Login successful',
        user: user
      }
    else
      {
        token: nil,
        message: 'Invalid email or password',
        user: nil
      }
    end
  end
end
