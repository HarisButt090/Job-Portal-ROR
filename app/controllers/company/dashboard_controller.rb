
  class Company::DashboardController < ApplicationController
    before_action :authenticate_user!

    layout "company"
    def index
      # Dashboard logic will go here
    end
  end
