module Mutations
    class CreateUser < BaseMutation
      # Input argument
      argument :input, Types::Input::UserInputType, required: true
  
      # Return fields
      field :user, Types::UserType, null: true
      field :message, String, null: true
      field :errors, [String], null: true # Include this field
  
      def resolve(input:)
        # Extract values from the input argument
        user_params = input.to_h
  
        # Create the user
        user = User.new(user_params)
  
        if user.save
          # Send email after successful user creation
          UserMailer.with(user: user).welcome_email.deliver_later
          { user: user, errors: [], message: "User created successfully." }
        else
          # Return error if user creation fails
          { user: nil, errors: user.errors.full_messages, message: nil }
        end
      end
    end
  end
  