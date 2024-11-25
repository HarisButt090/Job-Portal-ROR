class Company::DashboardController < ApplicationController
  before_action :set_company
  before_action :set_employer, only: [:show_employer_dashboard]

  def index
    if @company.nil?
      redirect_to root_path, alert: "You do not belong to a company."
    else
      @employers = @company.employers
      @jobs = @company.jobs
      render layout: "company"

    end

  end

  def show_employer_dashboard
    if @employer.nil?
      redirect_to company_dashboard_path, alert: "You are not assigned as an employer."
    else
      @jobs = @employer.jobs
      render layout: "employer"
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def set_employer
    @employer = current_user.employer
  end
end
