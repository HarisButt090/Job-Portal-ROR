module Mutations
  class UpdateRecruiter < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :email, String, required: false
    argument :department, String, required: false

    field :recruiter, Types::Company::RecruiterType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, email: nil, department: nil)
      user = context[:current_user]

      unless user&.company_admin?
        raise GraphQL::ExecutionError, "Only a company admin can update recruiters."
      end

      recruiter = user.company.recruiters.find_by(id: id)
      unless recruiter
        raise GraphQL::ExecutionError, "Recruiter not found."
      end

      recruiter.user.name = name if name.present?
      recruiter.department = department if department.present?

      if email.present? && recruiter.user.email != email
        recruiter.user.email = email
        recruiter.user.skip_reconfirmation!
        if recruiter.user.save
          recruiter.user.invite!
        else
          return { recruiter: nil, errors: recruiter.user.errors.full_messages }
        end
      end      

      if recruiter.save
        { recruiter: recruiter, errors: [] }
      else
        { recruiter: nil, errors: recruiter.errors.full_messages }
      end
    end
  end
end
