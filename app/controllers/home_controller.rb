class HomeController < ApplicationController

  skip_before_action :session_check, :only => ["index", "about"]

  #가장 처음 마주하는 페이지
  def index
    redirect_to "/main" unless session[:user_id].nil?
  end

  #클래스라이언 소개페이지
  def about
  end
end
