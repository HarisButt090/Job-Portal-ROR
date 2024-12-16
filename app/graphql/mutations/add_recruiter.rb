module Mutations
    class AddRecruiter < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :department, String, required: true
  
      field :recruiter, Types::Company::RecruiterType, null: true
      field :errors, [String], null: false
  
      def resolve(name:, email:, department:)
        user = context[:current_user]
  
        unless user&.company_admin?
          raise GraphQL::ExecutionError, "Only a company admin can add recruiters."
        end
  
        recruiter_user = User.invite!(email: email, name: name)
        recruiter_user.invited_by = user
        recruiter_user.role = 'employer'
        recruiter_user.save!
  
        recruiter = user.company.recruiters.new(
          user: recruiter_user,
          department: department,
          joined_date: Time.zone.now
        )
  
        if recruiter.save
          { recruiter: recruiter, errors: [] }
        else
          { recruiter: nil, errors: recruiter.errors.full_messages }
        end
      end
    end
  end
  