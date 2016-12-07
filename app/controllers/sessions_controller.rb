class SessionsController < ApplicationController
  #layout :false

  def new
    #로그인 form
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to "/evaluations/index"
    else
      flash[:danger] = 'email과 password를 다시 확인해주세요!'
      flash[:danger] = 'email과 password를 다시 확인해주세요!'
      flash[:danger] = 'email과 password를 다시 확인해주세요!'
      render 'new'
    end
  end

  def destroy
    #로그아웃 process
    log_out if logged_in?
    redirect_to root_url
  end
end
