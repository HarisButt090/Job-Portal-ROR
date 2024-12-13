class GraphqlController < ApplicationController
  before_action :authenticate_user

  def execute
    context = {
      current_user: current_user,
      request: request
    }
    
    binding.pry

    result = JobPortalSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: context,
      operation_name: params[:operationName]
    )
    render json: result
  rescue StandardError => e
    handle_error_in_development(e)
  end

  private

  def authenticate_user
    header = request.headers['Authorization']
    binding.pry
    return unless header.present? && header.start_with?('Bearer ')
  
    token = header.split(' ').last
    binding.pry
    secret_key = Rails.application.secret_key_base
    binding.pry
  
    begin
      decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
      binding.pry
      payload = decoded_token.first
      binding.pry
  
      Rails.logger.info "Decoded Payload: #{payload}"
  
      user_id = payload['sub']
      binding.pry
      @current_user = User.find_by(id: user_id)
      binding.pry
  
    rescue JWT::DecodeError => e
      Rails.logger.error "JWT Error: #{e.message}"
      @current_user = nil
    end
  end
  

  def current_user
    @current_user
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? JSON.parse(ambiguous_param) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    raise e unless Rails.env.development?

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
