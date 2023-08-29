class ApplicationController < ActionController::API
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, if: :devise_controller?
end
