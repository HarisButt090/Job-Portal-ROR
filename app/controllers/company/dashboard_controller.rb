
  class Company::DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      # Dashboard logic will go here
    end
  end
