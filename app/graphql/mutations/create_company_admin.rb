class Mutations::CreateCompanyAdmin < Mutations::BaseMutation
    argument :company_attributes, Types::Company::CompanyAttributes, required: true
    argument :user_attributes, Types::User::UserAttributes, required: true
  
    field :user, Types::User::UserType, null: true
    field :company, Types::Company::CompanyType, null: true
    field :message, String, null: true
    field :errors, [String], null: true
  
    def resolve(company_attributes:, user_attributes:)
      user_params = {
        name: user_attributes[:name],
        email: user_attributes[:email],
        password: user_attributes[:password],
        role: user_attributes[:role]
      }
  
      company_params = {
        name: company_attributes[:name],
        industry: company_attributes[:industry],
        employee_size: company_attributes[:employee_size],
        address: company_attributes[:address]
      }
  
      ApplicationRecord.transaction do
        user = User.new(user_params)
  
        if user.save
          company = Company.new(company_params)
          company.user = user
  
          if company.save
            UserMailer.with(user: user).verification_email.deliver_later
  
            return {
              user: user,
              company: company,
              message: "Company Admin created successfully.",
              errors: []
            }
          else
            raise ActiveRecord::Rollback, "Company errors: #{company.errors.full_messages.join(", ")}"
          end
        else
          raise ActiveRecord::Rollback, "User errors: #{user.errors.full_messages.join(", ")}"
        end
      end
    rescue ActiveRecord::Rollback => e
      { user: nil, company: nil, message: nil, errors: [e.message] }
    end
  end
  