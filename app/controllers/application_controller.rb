class ApplicationController < ActionController::Base
  include Mobvious::Rails::Controller
  include SessionsHelper #여기에 로그인, 로그아웃, current_user와 관련된 코드가 있음
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    redirect_to info_path, alert: t(:evaluation_lack)
  end

  def goto_login
    unless logged_in? #로그인이 안되어 있는데, 특정페이지로 접근하려고 한다면
        flash[:warning] = '로그인이 필요한 서비스 입니다'
        redirect_to root_url #루트페이지
    end
  end

  def goto_main
    if logged_in? #로그인이 되어있는데, 로그인 혹은 회원가입페이지로 접근하려고 한다면
       redirect_to '/main' #메인으로
    end
  end

  #returns false unless mobile
  def mobile_check
    for_device_type :mobile do
      @is_mobile = true
    end
  end
end