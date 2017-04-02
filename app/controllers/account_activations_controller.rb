class AccountActivationsController < ApplicationController
  def edit
    #인증 이메일 활성 process
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      if user.activate # 3시간 이내여서 활성화 되었으면
        log_in user
        flash[:success] = "이메일이 인증되어, 계정이 활성화되었습니다!"
        redirect_to '/main'
      else
        flash[:warning] = "이메일 인증시간이 초과되었습니다. 재전송버튼을 눌러주세요"
        redirect_to '/'
      end
    else
      flash[:warning] = "[에러] 유효하지않은 링크입니다."
      redirect_to root_url
    end
  end

  def authMail
    #인증 이메일 안내 view
    # @email = params[:e]
    @email =  User.find_by(id: session[:user_id]).email
  end

  def re_authMail
    #인증 이메일 재전송 view

  end

  def resend_authMail
    #인증 이메일 재전송 process
    user = User.find_by_email(params[:re_authMail][:email])

    if !user #이메일 주소 없으면
      @msg = "등록되지 않은 이메일 주소입니다."
      render 're_authMail'

    elsif user.activated?
      @msg = "이미 인증된 이메일 입니다!"
      render 're_authMail' #로그인하라고 로그인페이지로 리다이렉트

    elsif user && !user.activated? #사용자가 있으면서 아직 활성화가 되지 않았다면
      if user.resend_activation_email #이메일 재전송
        user.send_activation_email
        redirect_to "/signup/send_authMail/#{user.email}" #이메일 인증 안내 페이지로
      else
        flash[:warning] = "어머나, 문제가 생겼어요!"
        redirect_to '/signup/resend_authMail'
      end
    end

  end
end
