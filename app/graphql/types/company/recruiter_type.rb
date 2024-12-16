module Types
    module Company
      class RecruiterType < BaseObject
        field :id, ID, null: false
        field :name, String, null: true
        field :email, String, null: true
        field :department, String, null: true
        field :joined_date, GraphQL::Types::ISO8601DateTime, null: true
  
        def name
          object.user.name
        end
  
        def email
          object.user.email
        end
      end
    end
  end
  