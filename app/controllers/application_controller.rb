# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :set_current_user

  def after_sign_in_path_for(resource)
    company_dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  private

  def set_current_user
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    begin
      payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
      @current_user = User.find(payload['sub'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end
end
