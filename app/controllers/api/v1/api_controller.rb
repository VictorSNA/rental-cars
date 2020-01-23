class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_precondition_failed

  def render_not_found(exception)
    render json: exception.message, status: :not_found
  end

  def render_precondition_failed(exception)
    render json: exception.message, status: :precondition_failed
  end

end