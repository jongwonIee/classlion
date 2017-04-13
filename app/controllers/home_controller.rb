class HomeController < ApplicationController
  before_action :goto_main, only: [:index]

  #가장 처음 마주하는 페이지
  def index
    #redirect_to "/main" unless session[:user_id].nil? #세션이 있는 상태면 main으로 리다이렉트하는 대장님 코드
    # session.delete(:user_id) #session유지 된 상태에서 db:drop한 경우 사용할 수 있는 임시코드
  end

  #클래스라이언 소개페이지
  def about
  end
end
