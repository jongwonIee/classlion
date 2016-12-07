class UsersController < ApplicationController
  #layout :false

  def show
    #마이페이지로 대처? 고민해볼 것
    @user = User.find(params[:id])
  end

  def new
    #회원가입 form
    @user = User.new
  end

  def create
    #회원가입 process
    user = User.new(user_params)

    if user.save
      flash[:success] = "로그인 성공!"
      log_in user #자동으로 로그인
      redirect_to "/evaluations/index" #강평 목록이 있는 곳으로 리다이렉트
    else
      render 'new'
      println(user.errors.full_messages)
    end

  end

  def edit
    #회원정보 수정 form
    @user = User.find(params[:id])
  end

  def update
    #회원정보 수정 process
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
    #업데이트 성공시
      flash[:success] = "변경 완료!"
    else
      flash[:warning] = "어머나, 문제가 생겼어요!"
      render 'edit'
    end
  end
  private

  def user_params
    params.require(:user).permit(:email, :nickname, :is_boy, :university_id,
                                 :major_id,:password, :password_confirmation)
  end
end
