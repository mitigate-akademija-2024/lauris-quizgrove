class ApplicationController < ActionController::Base
    # helper_method :current_user
    before_action :authenticate_user!

    # def current_user
    #   @current_user ||= User.find(session[:user_id]) if session[:user_id] 
      
    # #   apstities sito
    # end

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
