class Mutations::CreateJobSeeker < Mutations::BaseMutation
    argument :job_seeker_attributes, Types::JobSeeker::JobSeekerAttributes, required: true
    argument :user_attributes, Types::User::UserAttributes, required: true
  
    field :user, Types::User::UserType, null: true
    field :job_seeker, Types::JobSeeker::JobSeekerType, null: true
    field :message, String, null: true
    field :errors, [String], null: true
  
    def resolve(job_seeker_attributes:, user_attributes:)
      user_params = {
        name: user_attributes[:name],
        email: user_attributes[:email],
        password: user_attributes[:password],
        role: user_attributes[:role]
      }
  
      job_seeker_params = {
        linkedin_profile_url: job_seeker_attributes[:linkedin_profile_url],
        github_portfolio_url: job_seeker_attributes[:github_portfolio_url],
        preferred_job_type: job_seeker_attributes[:preferred_job_type],
        city: job_seeker_attributes[:city],
        address: job_seeker_attributes[:address]
      }
  
      ApplicationRecord.transaction do
        user = User.new(user_params)
  
        if user.save
          job_seeker = JobSeeker.new(job_seeker_params)
          job_seeker.user = user
  
          if job_seeker.save
            UserMailer.with(user: user).verification_email.deliver_later
  
            return {
              user: user,
              job_seeker: job_seeker,
              message: "Job Seeker created successfully.",
              errors: []
            }
          else
            raise ActiveRecord::Rollback, "Job Seeker errors: #{job_seeker.errors.full_messages.join(", ")}"
          end
        else
          raise ActiveRecord::Rollback, "User errors: #{user.errors.full_messages.join(", ")}"
        end
      end
    rescue ActiveRecord::Rollback => e
      { user: nil, job_seeker: nil, message: nil, errors: [e.message] }
    end
  end
  