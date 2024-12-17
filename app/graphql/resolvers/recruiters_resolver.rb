module Resolvers
    class RecruitersResolver < Resolvers::BaseResolver
      type [Types::Company::RecruiterType], null: true
  
      argument :id, ID, required: false
  
      def resolve(id: nil)
        user = context[:current_user]
  
        unless user&.company_admin?
          raise GraphQL::ExecutionError, "Only a company admin can view recruiters."
        end
  
        if id.present?
          user.company.recruiters.includes(:user).find_by(id: id).then do |recruiter|
            raise GraphQL::ExecutionError, "Recruiter not found." if recruiter.nil?
            [recruiter]
          end
        else
          user.company.recruiters.includes(:user)
        end
      end
    end
  end
  