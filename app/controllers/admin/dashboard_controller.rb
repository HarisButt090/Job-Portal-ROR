class Admin::DashboardController < ApplicationController
  before_action :authorize_super_admin

  def index
  end

  private

  def authorize_super_admin
    redirect_to root_path, alert: "Access denied" unless current_user&.super_admin?
  end
end
