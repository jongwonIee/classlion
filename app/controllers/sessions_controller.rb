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
        redirect_to root_url
      else #이메일 인증을 하지 않은 경우
        redirect_to not_activated_url
      end
    else #이메일과 비번에 문제가 있는 경우
      flash[:success] = "비밀번호와 아이디가 틀림"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    log_out 
    flash[:success] = '로그아웃되었습니다'
    redirect_to root_url
  end
end
