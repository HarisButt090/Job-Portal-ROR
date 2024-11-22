
class Employer::DashboardController < ApplicationController
    before_action :authenticate_user!

    layout "employer"
    def index
    end
  end
