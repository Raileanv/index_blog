class ApplicationController < ActionController::API
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, if: :devise_controller?

  private

  def current_user
    current_devise_api_token&.resource_owner
  end
end
