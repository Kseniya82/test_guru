class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :authenticate_user!
  helper_method :logged_in?

  private

  def authenticate_user!
    unless current_user
      cookies[:redirect_path] = request.fullpath
      redirect_to login_path, alert: 'Login failed! Verify Email and Password please'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
