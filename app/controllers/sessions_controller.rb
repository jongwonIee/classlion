class SessionsController < ApplicationController

  skip_before_action :session_check, :only => ["new", "create"]

  def new
    #로그인 form
    redirect_to '/main' if logged_in? #이미 로그인된 상태라면 main페이지로 리다이렉트
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:notice] = '어서오세요!'
        redirect_to "/main"
      else
        message = "계정이 활성화되지 않았습니다."
        message += "이메일을 인증해주세요"
        flash[:warning] = message
        redirect_to "/signup/send_authMail/#{user.email}" #이메일 인증 안내 페이지로
      end
    else
      @msg = 'email과 password를 다시 확인해주세요!'
      render 'new'
    end
  end

  def destroy
    #로그아웃 process
    log_out(@current_user)
    flash[:success] = '로그아웃 되었습니다!'
    redirect_to root_url
  end
end
