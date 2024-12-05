module Types
  module User
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :email, String, null: false
      field :role, String, null: false
      field :status, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      # Associations
      field :company, Types::Company::CompanyType, null: true
    end
  end
end
  