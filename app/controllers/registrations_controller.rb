class RegistrationsController < Devise::RegistrationsController
  def new_company_admin
    build_resource({})
    resource.build_company
    render template: "users/registrations/new_company_admin"
  end

  def create
    build_resource(sign_up_params)

    if params[:user][:company_attributes].present?
      resource.build_company(company_params)
    end

    if resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        redirect_to verification_success_path and return
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        redirect_to verification_success_path and return
      end
    else
      clean_up_passwords resource
      render template: "users/registrations/new_company_admin"
    end
  end

  def verification_success
    render template: "users/registrations/verification_success"
  end

  private

  def company_params
    params.require(:user).require(:company_attributes).permit(:name, :industry, :employee_size, :address)
  end
end
