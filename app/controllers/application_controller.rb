class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def event_notification
  if day_passed < 7
    flash[:message] = "正常生活 Day #{day_passed}"
  else
    flash[:message] = "垃圾減量 Day #{day_passed - 7}"
  end
  end
  helper_method :event_notification

  def day_passed
    start_date = "2016-12-14 00:00:00 +0800"
    day_passed = (DateTime.now - start_date.to_date).to_i + 1
  end
  helper_method :day_passed

  def current_user
    if cookies[:user_id]
      session[:user_id] = cookies.encrypted[:user_id]
    end
    if session[:user_id] && !User.exists?(session[:user_id])
      session[:user_id] = nil
      cookies.delete :user_id
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_admin
    if current_user
      if !current_user.is_admin
        flash[:message] = 'You have no permisison to do so...'
        redirect_to root_path
      end
    end
  end
  helper_method :is_admin

  def require_login
    if !current_user
      flash[:message] = 'Login to continue...'
      redirect_to login_path
    end
  end
end
