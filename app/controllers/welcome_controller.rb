class WelcomeController < ApplicationController
  before_action :redirect_if_logged_in, only: [:index]
  before_action :authenticate_user!, only: [:login_index]
  def index
  end

  def login_index
    # Code for the post-login page
  end

  private

  def redirect_if_logged_in
    if user_signed_in?
      redirect_to dashboard_path  # Change this to the path you want logged-in users to go to
    end
  end
end
