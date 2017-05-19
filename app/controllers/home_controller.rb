class HomeController < ApplicationController

  #가장 처음 마주하는 페이지
  def index
    render "evaluations/main" if logged_in?
  end

  #클래스라이언 소개페이지
  def about
  end
end
