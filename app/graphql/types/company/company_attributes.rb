module Types
    module Company
      class CompanyAttributes < Types::BaseInputObject
        argument :name, String, required: true
        argument :industry, String, required: true
        argument :employee_size, Integer, required: true
        argument :address, String, required: true
      end
    end
  end
  