class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

  # finds and returns the current user based on session user id
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # checks if a user is currently logged in
  def logged_in?
    !!current_user
  end

  # ensures user is logged in before accessing protected routes
  def require_login
    unless logged_in?
      flash[:alert] = "Please log in to access Contactvault"
      redirect_to login_path
    end
  end
end
