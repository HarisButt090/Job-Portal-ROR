module Types
  module JobSeeker
    class JobSeekerType < Types::BaseObject
      field :id, ID, null: false
      field :linkedin_profile_url, String, null: true
      field :github_portfolio_url, String, null: true
      field :preferred_job_type, String, null: true
      field :city, String, null: true
      field :address, String, null: true
      field :resume, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
  