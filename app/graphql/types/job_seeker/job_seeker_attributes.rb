  module Types
    module JobSeeker
      class JobSeekerAttributes < Types::BaseInputObject
        argument :linkedin_profile_url, String, required: true
        argument :github_portfolio_url, String, required: true
        argument :preferred_job_type, String, required: true
        argument :city, String, required: true
        argument :address, String, required: true
        argument :resume, Types::FileUpload, required: false
      end
    end
  end
