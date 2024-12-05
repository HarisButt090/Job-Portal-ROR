
module Types
  class MutationType < Types::BaseObject
    field :create_company_admin, mutation: Mutations::CreateCompanyAdmin
  end
end
