class HomeController < ApplicationController

  def index #가장 처음 마주하는 페이지
    if logged_in?   
      if current_user.activated?
        redirect_to main_url
      else 
        redirect_to not_activated_url
      end
    end
  end

  def about #클래스라이언 소개페이지
  end
end
