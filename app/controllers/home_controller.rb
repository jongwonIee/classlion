class HomeController < ApplicationController
  skip_before_action :session_check, :only => ["index", "about"]

  #가장 처음 마주하는 페이지
  def index
    redirect_to "/main" unless session[:user_id].nil?
    #session.delete(:user_id) #session유지 된 상태에서 db:drop한 경우 사용할 수 있는 임시코드
    #가장 처음 마주하는 페이지
  end

  #클래스라이언 소개페이지
  def about
  end
end
