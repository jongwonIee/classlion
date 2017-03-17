class HomeController < ApplicationController
  before_action :session_check

  #가장 처음 마주하는 페이지
  def index
    redirect_to "/main" if @current_user #이미 로그인한 상태라면 main페이지로 리다렉트
    #session.delete(:user_id) #session유지 된 상태에서 db:drop한 경우 사용할 수 있는 임시코드
  end

  #클래스라이언 소개페이지
  def about
  end
end
