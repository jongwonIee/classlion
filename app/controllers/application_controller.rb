class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to info_path, alert: "강평열람 권한을 오픈하기 위해 강평을 해주세요!" }
    end
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  # def time_diff(start_time, end_time)
  #   seconds_diff = (start_time - end_time).to_i.abs
  #
  #   hours = seconds_diff / 3600
  #   seconds_diff -= hours * 3600
  #
  #   minutes = seconds_diff / 60
  #   seconds_diff -= minutes * 60
  #
  #   seconds = seconds_diff
  #
  #   "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  # end

end
