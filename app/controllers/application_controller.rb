class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :session_check

  rescue_from CanCan::AccessDenied do
    redirect_to info_path, alert: t(:evaluation_lack)
  end

  def session_check
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id == cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    else
      redirect_to "/"
    end
  end

  #for cancancan
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

end