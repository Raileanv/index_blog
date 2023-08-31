class ApplicationController < ActionController::API
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, if: :devise_controller?
  before_action :ban_check!

  private

  def current_user
    current_devise_api_token&.resource_owner
  end

  def authenticate_admin!
    return if current_user&.admin?

    render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
  end

  def ban_check!
    return unless current_user.access_locked?

    render json: { error: 'Your account has been banned' }, status: :unauthorized
  end
end
