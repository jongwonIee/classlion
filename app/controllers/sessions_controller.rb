class SessionsController < ApplicationController

  skip_before_action :session_check, :only => ["new", "create"]

  def new
    #로그인 form
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:notice] = '어서오세요!'
      redirect_to "/main"
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
