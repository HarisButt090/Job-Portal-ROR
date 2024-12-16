
module Types
  class MutationType < Types::BaseObject
    field :create_company_admin, mutation: Mutations::CreateCompanyAdmin
    field :create_job_seeker, mutation: Mutations::CreateJobSeeker
    field :user_login , mutation: Mutations::UserLogin
    field :user_logout, mutation: Mutations::UserLogout
    field :add_recruiter, mutation: Mutations::AddRecruiter

  end
end
