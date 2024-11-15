  class JobSeeker::DashboardController < ApplicationController
    before_action :authenticate_user!

    layout "job_seeker"
  
    def index
    end
  end
