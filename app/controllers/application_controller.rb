class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id] && !User.exists?(session[:user_id])
      session[:user_id] = nil
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_admin
    if current_user
      return @current_user.is_admin
    else
      return false
    end
  end
  helper_method :is_admin

  def authorize
    redirect_to '/login' unless current_user
  end
end
