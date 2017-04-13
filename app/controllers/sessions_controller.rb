class SessionsController < ApplicationController
  before_action :goto_main, only: [:new]

  def new
    #로그인 form
    #redirect_to '/main' if @current_user && @current_user.activated? #이미 로그인한 상태고, 이메일인증 된 경우 main페이지로 리다렉트
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          flash[:notice] = '어서오세요!'
          render js: "window.location='/main'"
        else
          render js: "window.location='/signup/send_authMail'"
        end
      else
        respond_to do |format|
          format.js {
            render template: 'sessions/sessionError.js.erb',
                   layout: false
          }
        end #respond_to
      end
  end

  def destroy
    #로그아웃 process
    log_out if logged_in? #로그인이 되어있는 상태에서만 로그아웃을 함으로써, 다른 브라우저에서 로그아웃한 상태에서 다시 로그아웃하려고 할 때 발생하는 문제 해결
    flash[:success] = '로그아웃 되었습니다!'
    redirect_to root_url
  end
end
