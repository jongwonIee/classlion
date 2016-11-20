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

  end
  # def session
  #   #로그인
  # end
end
