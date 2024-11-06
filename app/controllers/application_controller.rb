class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Devise::Controllers :Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    # Redirect based on user role
    if resource.role == "company_admin"
      dashboard_path
    else
      dashboard_path
    end
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
  end
end
