class ApplicationController < ActionController::Base

  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :session_check

  rescue_from CanCan::AccessDenied do
    redirect_to info_path, alert: t(:evaluation_lack) 
  end

	def session_check
    redirect_to "/" unless logged_in?
	end

end
