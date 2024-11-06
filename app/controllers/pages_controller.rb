class PagesController < ApplicationController
  def landing
<<<<<<< HEAD
    if user_signed_in?
      case current_user.role
      when "company_admin"
        redirect_to company_dashboard_path
      when "job_seeker"
        redirect_to job_seeker_dashboard_path
      when "employer"
        redirect_to employer_dashboard_path
      when "super_admin"
        redirect_to admin_dashboard_path
      else
        redirect_to root_path, alert: "Invalid role or access!"
      end
    end
=======
>>>>>>> d4946ac (Company Registration through devise and redirecting to dashboard)
  end
end
