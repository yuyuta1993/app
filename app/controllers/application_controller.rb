class ApplicationController < ActionController::Base
  helper_method  :logged_in?, :current_user
  protect_from_forgery with: :exception

  def logged_in?
    !!session[:user_id] || !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "ログインが必要です"
      redirect_to login_path # ログインページにリダイレクト
    end
  end
  
end
