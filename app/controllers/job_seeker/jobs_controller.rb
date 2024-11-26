
class JobSeeker::JobsController < ApplicationController
  layout "job_seeker"
  before_action :authenticate_user!


  def show
    @job = Job.find(params[:id])
  end

  def apply
    @job = Job.find(params[:id])
    @job_application = JobApplication.new
  end

  def submit_application
    @job_application = JobApplication.new(job_application_params)
    @job_application.job = Job.find(params[:id])
    @job_application.job_seeker = current_user.job_seeker

    Rails.logger.debug "CV Attached: #{@job_application.cv.attached?}"

    if @job_application.save
      redirect_to job_seeker_dashboard_path, notice: "Application submitted successfully!"
    else
      Rails.logger.error "Job Application Errors: #{@job_application.errors.full_messages.join(', ')}"
      render :apply
    end
  end

  def my_applications
    @applications = current_user.job_seeker.job_applications.includes(:job)
  end

  def show_application
    @job_application = current_user.job_seeker.job_applications.find(params[:id])
  end
  

  private

  def job_application_params
    params.require(:job_application).permit(:total_experience, :last_organization, :latest_degree, :is_education_completed, :graduated_year, :cv)
  end
end

