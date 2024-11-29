class Company::JobsController < ApplicationController
  before_action :set_company
  before_action :set_job, only: [
    :show, :edit, :update, :destroy, :publish, :close, :open,
    :view_application, :accept_application, :reject_application,
    :show_applications, :schedule_interview, :create_interview,
    :update_interview_status
  ]
  before_action :set_job_application, only: [
    :view_application, :accept_application, :reject_application,
    :schedule_interview, :create_interview
  ]
  before_action :set_interview, only: [:update_interview_status]

  layout -> { current_user.company_admin? ? "company" : "employer" }

  def new
    @job = @company.jobs.new
  end

  def create
    @job = @company.jobs.new(job_params)
    @job.job_posted_at = Time.current
    @job.employer_id = current_user.id if current_user.employer?

    if @job.save
      redirect_to dashboard_path_for_user, notice: 'Job was successfully created.'
    else
      flash.now[:alert] = 'Unable to save job. Please check the errors below.'
      render :new
    end
  end

  def drafts
    @draft_jobs = jobs_scope.where(displayed_status: 0, job_status: 0)
  end

  def show; end

  def edit; end

  def update
    if @job.update(job_params)
      redirect_to dashboard_path_for_user, notice: 'Job was successfully updated.'
    else
      flash.now[:alert] = 'Unable to update job. Please check the errors below.'
      render :edit
    end
  end

  def destroy
    if @job.destroy
      redirect_to dashboard_path_for_user, notice: 'Job was successfully deleted.'
    else
      redirect_to dashboard_path_for_user, alert: 'Failed to delete the job.'
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
    @active_jobs = jobs_scope.where(displayed_status: 1, job_status: 1)
  end

  def close
    if @job.update(displayed_status: 2, job_status: 0)
      redirect_to manage_company_jobs_path, notice: 'Job was successfully closed.'
    else
      redirect_to manage_company_jobs_path, alert: 'Failed to close the job.'
    end
  end

  def archived
    @archived_jobs = jobs_scope.where(displayed_status: 2, job_status: 0)
  end

  def open
    if @job.update(displayed_status: 1, job_status: 1)
      redirect_to archived_company_jobs_path, notice: 'Job was successfully reopened and moved to active jobs.'
    else
      redirect_to archived_company_jobs_path, alert: 'Failed to reopen the job. Please try again.'
    end
  end

  def show_applications
    @job_applications = @job.job_applications
  end

  def view_application
    if @job_application.status == 'pending'
      @job_application.update(status: 'screened')
    end
  end

  def accept_application
    if @job_application.update(status: 'accepted')
      redirect_to show_applications_company_job_path(@job), notice: 'Application accepted.'
    else
      redirect_to show_applications_company_job_path(@job), alert: 'Failed to accept the application.'
    end
  end

  def reject_application
    if @job_application.status == 'accepted'
      @job_application.interviews.destroy_all if @job_application.interviews.any?
    end

    if @job_application.update(status: 'denied')
      redirect_to show_applications_company_job_path(@job), notice: 'Application rejected.'
    else
      redirect_to show_applications_company_job_path(@job), alert: 'Failed to reject the application.'
    end
  end

  def schedule_interview
    if @job_application.status == 'accepted'
      @interview = @job_application.interviews.build
    else
      redirect_to show_applications_company_job_path(@job), alert: 'You can only schedule an interview for accepted applications.'
    end
  end

  def create_interview
    @interview = @job_application.interviews.build(interview_params)
    if @interview.save
      redirect_to show_applications_company_job_path(@job), notice: 'Interview scheduled successfully.'
    else
      flash.now[:alert] = 'Error scheduling interview. Please check the input.'
      render :schedule_interview
    end
  end

  def applications_overview
    @job_applications = @company.jobs.includes(:job_applications).flat_map(&:job_applications)
  end

  def update_interview_status
    job = Job.find(params[:id])
    interview = job.job_applications.flat_map(&:interviews).find { |i| i.id == params[:interview_id].to_i }
  
    if interview
      interview.update(status: params[:status])
      redirect_to company_job_path(job), notice: 'Interview status updated.'
    else
      redirect_to company_job_path(job), alert: 'Interview not found.'
    end
  end
  
  private

  def set_job_application
    @job_application = JobApplication.find_by(id: params[:application_id], job: @job)
    redirect_to show_applications_company_job_path(@job), alert: 'Application not found.' unless @job_application
  end

  def set_interview
    @interview = Interview.find_by(id: params[:interview_id], job: @job)
    if @interview.nil?
      redirect_to applications_overview_company_jobs_path, alert: 'Interview not found or not associated with this job.'
    end
  end

  def set_company
    @company = current_user.company
    redirect_to root_path, alert: "Company not found" unless @company
  end

  def jobs_scope
    if current_user.company_admin?
      @company.jobs
    elsif current_user.employer?
      @company.jobs.where(employer_id: current_user.id)
    else
      Job.none
    end
  end

  def set_job
    @job = jobs_scope.find_by(id: params[:id])
    redirect_to dashboard_path_for_user, alert: 'Job not found or unauthorized access.' unless @job
  end

  def dashboard_path_for_user
    if current_user.company_admin?
      company_dashboard_path
    elsif current_user.employer?
      employer_dashboard_path
    else
      root_path
    end
  end

  def job_params
    params.require(:job).permit(:title, :address, :city, :job_description, :responsibilities,
                                :requirements, :experience, :salary, :qualification, :job_type)
  end

  def interview_params
    params.require(:interview).permit(:scheduled_at)
  end
end
