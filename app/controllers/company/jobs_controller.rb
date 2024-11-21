class Company::JobsController < ApplicationController
  before_action :set_company
  before_action :set_job, only: [:show, :edit, :update, :destroy, :publish, :close, :open]
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
    @draft_jobs = @company.jobs.where(displayed_status: 0, job_status: 0)
  end

  def show
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to company_dashboard_path, notice: 'Job was successfully updated.'
    else
      flash.now[:alert] = 'Unable to update job. Please check the errors below.'
      render :edit
    end
  end

  def destroy
    Rails.logger.debug "Destroy action triggered for job ID: #{@job.id}"
    if @job.destroy
      redirect_to company_dashboard_path, notice: 'Job was successfully deleted.'
    else
      redirect_to company_dashboard_path, alert: 'Failed to delete the job.'
    end
  end

  def publish
    if @job.update(displayed_status: 1, job_status: 1)
      redirect_to drafts_company_jobs_path, notice: 'Job was successfully published and is now active.'
    else
      redirect_to drafts_company_jobs_path, alert: 'Failed to publish the job. Please try again.'
    end
  end
 
  def manage
    @active_jobs = @company.jobs.where(displayed_status: 1, job_status: 1)
  end
  
  def close
    
    if @job.update(displayed_status: 2, job_status: 0)
      redirect_to manage_company_jobs_path, notice: 'Job was successfully closed.'
    else
      redirect_to manage_company_jobs_path, alert: 'Failed to close the job.'
    end
  end
 
  def archived
    @archived_jobs = @company.jobs.where(displayed_status: 2 , job_status: 0)
  end

  def open

    if @job.update(displayed_status: 1, job_status: 1)
      redirect_to archived_company_jobs_path, notice: 'Job was successfully reopened and moved to active jobs.'
    else
      redirect_to archived_company_jobs_path, alert: 'Failed to reopen the job. Please try again.'
    end
  end
  

  private

  def set_company
    @company = Company.find_by(user_id: current_user.id)
    redirect_to root_path, alert: "Company not found" unless @company
  end

  def set_job
    @job = @company.jobs.find_by(id: params[:id])
    redirect_to drafts_company_jobs_path, alert: 'Job not found or does not belong to your company.' unless @job
  end

  def job_params
    params.require(:job).permit(:title, :address, :city, :job_description, :responsibilities, 
                                :requirements, :experience, :salary, :qualification, :job_type)
  end
end
