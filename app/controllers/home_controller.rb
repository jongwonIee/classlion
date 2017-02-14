class HomeController < ApplicationController
  #layout :false
  def index
    #session.delete(:user_id) #session유지 된 상태에서 db:drop한 경우 사용할 수 있는 임시코드
    #가장 처음 마주하는 페이지
    if current_user
      redirect_to "/main" if logged_in?
    end

  end

  def about
    #클래스라이언 소개페이지
  end
end