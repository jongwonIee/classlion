class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "이메일이 인증되어, 계정이 활성화되었습니다!"
      redirect_to '/main'
    else
      flash[:warning] = "[에러] 유효하지않은 링크입니다."
      redirect_to root_url
    end
  end
end
