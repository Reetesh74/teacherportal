class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_students_path(current_user)
  end
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: :internal_server_error
  end
end
