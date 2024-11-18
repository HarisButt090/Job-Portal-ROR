module Shared
  class JobsController < ApplicationController
    before_action :set_company, only: [ :new, :create ]
    before_action :authorize_user

    # GET /shared/jobs/new
    def new
      @job = @company.jobs.new
    end

    # POST /shared/jobs
    def create
      @job = @company.jobs.new(job_params)
      @job.employer = current_user.employer # Associate job with the current user (employer)

      if @job.save
        redirect_to dashboard_path, notice: "Job was successfully created."
      else
        flash.now[:alert] = "Error creating job. Please check the form for errors."
        render :new
      end
    end

    private

    def set_company
      @company = current_user.company
    end

    def job_params
      params.require(:job).permit(
        :title, :address, :city, :job_description, :responsibilities,
        :requirements, :experience, :salary, :qualification, :job_type
      )
    end

    def authorize_user
      unless current_user.role.in?([ "company_admin", "recruiter" ])
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
  end
end
