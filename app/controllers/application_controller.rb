class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def after_sign_in_path_for(resource)
    dashboard_path  # Redirect to the dashboard page after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path  # Redirect to root (welcome page) after sign-out
  end
end