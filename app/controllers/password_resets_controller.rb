class PasswordResetsController < ApplicationController
  before_action :goto_main, only: [:new, :edit]
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = '비밀번호 재설정관련 메일이 전송되었습니다'
      redirect_to root_url
    else
      @msg = '등록되지않은 이메일입니다.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, '비밀번호는 필수정보입니다.')
      render 'edit'
    elsif params[:user][:password] != params[:user][:password_confirmation]
      @user.errors.add(:password, '비밀번호와 비밀번호확인이 일치하지 않습니다.')
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:info] = '비밀번호가 변경되었습니다'
      redirect_to '/main'
    else
      render 'edit'
    end

  end


  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  #Before filters

  def get_user
    @user = User.find_by(email: params[:email])
  end

  #유효한 사용자인지 확인
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  #토큰의 유효시간 확인
  def check_expiration
    if @user.password_reset_expired?
      flash[:warning] = '링크의 유효시간이 초과되었습니다'
      redirect_to new_password_reset_url
    end
  end
end
