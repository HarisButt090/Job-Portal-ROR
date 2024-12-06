class Company::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company_admin

  layout "company"

  def index
  end

  private

  def authorize_company_admin
    if current_user.role == 'job_seeker'
      redirect_to job_seeker_dashboard_path, alert: "Access denied. You were redirected to the job seeker dashboard."
    elsif current_user.role != 'company_admin'
      redirect_to root_path, alert: "Access denied. You are not authorized to access this page."
    end
  end
end
