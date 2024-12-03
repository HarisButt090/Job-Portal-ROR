class Company::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_company_admin

  layout "company"

  def index
  end

  private

  def authorize_company_admin
    unless current_user.role == 'company_admin'
      redirect_to root_path, alert: "Access denied. Only company admins can access the company dashboard."
    end
  end
end
