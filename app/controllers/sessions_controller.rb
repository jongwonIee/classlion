class SessionsController < ApplicationController
  def new
    #로그인 form
  end

  def create
    #로그인 process
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to "/evaluations/index"
    else
      flash[:danger] = 'email과 password를 다시 확인해주세요!'
      render 'new'
    end
  end

  def destroy
    #로그아웃 process
    reset_session
    redirect_to '/'
  end
end
