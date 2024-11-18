class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.build_company(company_params) if params[:user][:company_attributes].present?

    if resource.save
      handle_successful_signup(resource)
    else
      handle_failed_signup(resource)
    end
  end

  def update_role
    @user = User.new(sign_up_params)

    if @user.role == "company_admin"
      render turbo_stream: turbo_stream.replace("role_frame", partial: "users/registrations/company_details", locals: { f: @user })
    else
      render turbo_stream: turbo_stream.replace("role_frame", partial: "users/registrations/empty_company_details")
    end
  end

  def verify_email
    response.headers["Turbo-Frame"] = "_top"
    render template: "users/registrations/verify_email"
  end

  private

  def handle_successful_signup(resource)
    message = resource.active_for_authentication? ? :signed_up : :"signed_up_but_#{resource.inactive_message}"
    set_flash_message! :notice, message
    sign_up(resource_name, resource) if resource.active_for_authentication?
    expire_data_after_sign_in! unless resource.active_for_authentication?
    redirect_to verify_email_path, format: :html
  end

  def handle_failed_signup(resource)
    clean_up_passwords(resource)
    set_minimum_password_length if devise_mapping.validatable?
    flash.now[:alert] = "Could not create the account. Please check the form and try again."
    Rails.logger.debug { "Rendering new registration template due to errors: #{resource.errors.full_messages.join(', ')}" }
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
