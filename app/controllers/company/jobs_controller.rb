class Company::JobsController < ApplicationController
  before_action :set_company
  before_action :set_job, only: [:show]
   layout "company"
   
  def new
    @job = @company.jobs.new
  end

  def create
    @job = @company.jobs.new(job_params)
    @job.job_posted_at = Time.current

    if @job.save
      redirect_to company_dashboard_path, notice: 'Job was successfully created.'
    else
      flash.now[:alert] = 'Unable to save job. Please check the errors below.'
      render :new
    end
  end

  def drafts
    @draft_jobs = @company.jobs.where(displayed_status: 0)
  end

  def show
    @job
  end

  
  private

  def set_company
    @company = Company.find_by(user_id: current_user.id)
  end

  def set_job
    @job = @company.jobs.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :address, :city, :job_description, :responsibilities, 
                                :requirements, :experience, :salary, :qualification, :job_type)
  end
end
