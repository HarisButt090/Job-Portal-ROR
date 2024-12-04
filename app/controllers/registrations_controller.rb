class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.save
      role_based_redirect(resource)
    else
      handle_failed_signup(resource)
    end
  end

  def company_details
    @company = Company.new
    @user = User.find(params[:user_id])
  end

  def save_company_details
    user = User.find(params[:user_id])
    @company = Company.new(company_params)
    @company.user_id = user.id
  
    if @company.save
      redirect_to verify_email_path, notice: "Company details saved successfully!"
    else
      flash.now[:alert] = "There are errors in your form. Please correct them below."
      render :company_details, status: :unprocessable_entity
    end
  end
  

  def job_seeker_details
    @user = User.find(params[:user_id])
    @job_seeker = @user.build_job_seeker
  end

  def save_job_seeker_details
    @user = User.find(params[:user_id])
    @job_seeker = @user.build_job_seeker(job_seeker_params)
    binding.pry
  
    if @job_seeker.save
      redirect_to verify_email_path, notice: "Job seeker details saved successfully!"
    else
      flash.now[:alert] = "There were errors with your submission. Please correct them below."
      render :job_seeker_details, status: :unprocessable_entity
    end
  end
  
  def verify_email
    render template: "/devise/registrations/verify_email"
  end

  private

  def role_based_redirect(user)
    case user.role
    when "company_admin"
      redirect_to company_details_path(user_id: user.id)
    when "job_seeker"
      redirect_to job_seeker_details_path(user_id: user.id)
    else
      handle_default_redirect
    end
  end

  def handle_default_redirect
    set_flash_message! :notice, :signed_up
    sign_up(resource_name, resource)
    redirect_to root_path
  end

  def handle_failed_signup(resource)
    clean_up_passwords(resource)
    set_minimum_password_length if devise_mapping.validatable?
    flash.now[:alert] = "Could not create the account. Please check the form and try again."
    render :new, status: :unprocessable_entity
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
  end

  def company_params
    params.require(:company).permit(:name, :industry, :employee_size, :address)
  end

  def job_seeker_params
    params.require(:job_seeker).permit(:linkedin_profile_url, :github_portfolio_url, :preferred_job_type, :city, :address, :resume)
  end

  protected

  def after_sign_up_path_for(resource)
    verify_email_path
  end
end
