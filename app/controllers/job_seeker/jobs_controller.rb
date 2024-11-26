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

  private

  def job_application_params
    params.require(:job_application).permit(:total_experience, :last_organization, :latest_degree, :is_education_completed, :graduated_year, :cv)
  end
end

