class HomeController < ApplicationController
  #layout :false
  def index
    #가장 처음 마주하는 페이지
    redirect_to "/evaluations/index" if logged_in?
  end

  def about
    #클래스라이언 소개페이지
  end
end