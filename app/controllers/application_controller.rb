class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.job_seeker?
      job_seeker_dashboard_path
    elsif resource.company_admin?
      company_dashboard_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role, company_attributes: [ :name, :industry, :employee_size, :address ], job_seeker_attributes: [ :linkedin_profile_url, :github_portfolio_url, :preferred_job_type, :city, :address, :resume ] ])
  end
end
