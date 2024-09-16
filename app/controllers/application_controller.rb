class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:error] = "ログインが必要です"
      redirect_to login_path
    end
  end
end

