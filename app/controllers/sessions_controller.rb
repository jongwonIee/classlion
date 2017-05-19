class SessionsController < ApplicationController
  before_action :session_check, except: [:new, :create]

  def new
    #로그인 form
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.password?(params[:session][:password])
      log_in user
      if user.activated? #이메일 인증을 한 경우
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "#{user.nickname}님 안녕하세요 :)"
        redirect_to "/"
      else #이메일 인증을 하지 않은 경우
        redirect_to "/not_activated"
      end
    else #이메일과 비번에 문제가 있는 경우
      render template: 'sessions/sessionError.js.erb', layout: false
    end
  end

  def destroy
    #로그아웃 process
    log_out if logged_in? #로그인이 되어있는 상태에서만 로그아웃을 함으로써, 다른 브라우저에서 로그아웃한 상태에서 다시 로그아웃하려고 할 때 발생하는 문제 해결
    flash[:success] = '로그아웃되었습니다'
    redirect_to root_url
  end
end
