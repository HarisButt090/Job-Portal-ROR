module Types
  module Company
    class CompanyType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :industry, String, null: true
      field :employee_size, Integer, null: true
      field :address, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
  