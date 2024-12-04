class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin

  layout "admin"

  def index
  end

  private

  def authorize_super_admin
    if current_user.role == 'company_admin'
      redirect_to company_dashboard_path, alert: "Access denied. You were redirected to the company dashboard."
    elsif current_user.role == 'job_seeker'
      redirect_to job_seeker_dashboard_path, alert: "Access denied. You were redirected to the job seeker dashboard."
    elsif current_user.role != 'super_admin'
      redirect_to admin_dashboard_path, alert: "Access denied. You are not authorized to access this page."
    end
  end
end
