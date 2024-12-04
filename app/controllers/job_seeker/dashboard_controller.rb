class JobSeeker::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_job_seeker

  layout "job_seeker"

  def index
    # Job seeker dashboard logic
  end

  private

  def authorize_job_seeker
    if current_user.role == 'company_admin'
      redirect_to company_dashboard_path, alert: "Access denied. You were redirected to the company dashboard."
    elsif current_user.role != 'job_seeker'
      redirect_to root_path, alert: "Access denied. You are not authorized to access this page."
    end
  end
end
