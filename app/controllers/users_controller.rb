class UsersController < ApplicationController
  layout :false
  def sign_up
    #회원가입 뷰
    @user = User.new
  end

  def sign_in
    #로그인 뷰
  end

  def create
    #회원가입
    user = User.new
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    user.nickname = params[:user][:nickname]
    user.is_boy = params[:user][:is_boy]
    user.university_id = params[:user][:university]
    user.major_id = params[:user][:major]
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]

    if user.save
      session[:user_id] = user.id #자동으로 로그인
      redirect_to "/evaluations/index" #강평 목록이 있는 곳으로 리다이렉트
    else
      @errors = user.errors.full_messages.first if user.errors.any?
      print(user.errors.full_messages.first) if user.errors.any?
    end

  end
  # def session
  #   #로그인
  # end
end
