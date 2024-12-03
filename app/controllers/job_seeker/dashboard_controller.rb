  class JobSeeker::DashboardController < ApplicationController
    before_action :authenticate_user!

    layout "job_seeker"
  
    def index
      @jobs = Job.where(displayed_status: 'published').page(params[:page]).per(3)
    end    
  end
