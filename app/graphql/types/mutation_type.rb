
module Types
  class MutationType < Types::BaseObject
    field :create_company_admin, mutation: Mutations::CreateCompanyAdmin
    field :create_job_seeker, mutation: Mutations::CreateJobSeeker
  end
end
