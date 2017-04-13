class ApplicationController < ActionController::Base
  include Mobvious::Rails::Controller
  include SessionsHelper
  before_action :test_session_check
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    redirect_to info_path, alert: t(:evaluation_lack)
  end

  def logged_in_user
    unless logged_in? #로그인이 안되어 있는데, 특정페이지로 접근하려고 한다면
      flash[:warning] = "로그인해주세요!"
      redirect_to root_url #루트페이지
    end
  end

  def goto_main
    if logged_in? #로그인이 되어있는데, 로그인 혹은 회원가입페이지로 접근하려고 한다면
      redirect_to '/main'
    end
  end

  def test_session_check
    puts "hello world"
    puts ("logged_in?: " + logged_in?.to_s)

    if logged_in?
      puts current_user.nickname
      puts current_user
      puts @current_user
    else
      puts "nil" #로그인이 안되어 있으면 로그인해야징
    end
  end

  #for cancancan
  # def current_user
  #   return unless session[:user_id]
  #   @current_user ||= User.find(session[:user_id])
  # end

  #returns false unless mobile
  def mobile_check
    for_device_type :mobile do
      @is_mobile = true
    end
  end
end