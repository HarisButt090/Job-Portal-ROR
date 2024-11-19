class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if params[:user][:role] == "company_admin"
      resource.build_company(company_params)
    end

    if resource.save
      handle_successful_signup(resource)
    else
      handle_failed_signup(resource)
    end
  end

  def role_details
    if params[:role] == "company_admin"
      render partial: "users/registrations/company_details", locals: { f: User.new }
    else
      render html: ""
    end
  end

  def verify_email
    render template: "users/registrations/verify_email"
  end

  private

  def handle_successful_signup(resource)
    message = resource.active_for_authentication? ? :signed_up : :"signed_up_but_#{resource.inactive_message}"
    set_flash_message! :notice, message
    sign_up(resource_name, resource) if resource.active_for_authentication?
    expire_data_after_sign_in! unless resource.active_for_authentication?
    redirect_to verify_email_path(format: :html)
  end

  def handle_failed_signup(resource)
    clean_up_passwords(resource)
    set_minimum_password_length if devise_mapping.validatable?
    flash.now[:alert] = "Could not create the account. Please check the form and try again."
    render :new, status: :unprocessable_entity
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, company_attributes: [ :name, :industry, :employee_size, :address ])
  end


  def company_params
    params.require(:user).permit(company_attributes: [ :name, :industry, :employee_size, :address ])[:company_attributes]
  end

  protected

  def after_sign_up_path_for(resource)
    verify_email_path
  end
end
