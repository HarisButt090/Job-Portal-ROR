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
        token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  
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
  