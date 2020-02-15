class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found()
    redirect_to root_path, alert: 'Você não pode fazer essa ação'
  end
end
