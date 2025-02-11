class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :full_name, :location, :date_of_birth])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :full_name, :location, :date_of_birth])
  end
  allow_browser versions: :modern
end
