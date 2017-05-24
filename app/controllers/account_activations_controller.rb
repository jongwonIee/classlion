class AccountActivationsController < ApplicationController
  before_action :session_check, except: [:activate]

  def not_activated #인증 이메일 안내 view
    if !current_user.activated?
      email_original =  current_user.email
      email_split = email_original.split('@') #@를 중심으로 앞뒤로 자름
      email_slice = email_split[0].slice(0..1)#@앞부분은 2개만 겟하기
      @email = email_slice + "*****@" + email_split[1]
    else
      redirect_to root_url
    end
  end

  def activate #인증 이메일 활성 process
    auth_token = AuthToken.where(token: params[:token], auth_type: 1).take
    if !auth_token.nil? and !auth_token.user.nil?
      user = auth_token.user
      if !user.activated? and user.activate(auth_token) # 3시간 이내여서 활성화 되었으면
        log_in user
        flash[:success] = "이메일이 인증되었습니다 #{user.nickname}님 반갑습니다 :)"
        redirect_to root_url
      else # 그것이 아니면
        flash[:warning] = '유효하지않은 링크입니다.'
        redirect_to login_url
      end
    else
      flash[:warning] = '유효하지않은 링크입니다.'
      redirect_to login_url
    end
  end

  def retry_activation  #인증 이메일 재전송 process
    if !current_user.activated? #사용자가 있으면서 아직 활성화가 되지 않았다면
      current_user.send_activation_email
      flash[:success] = "이메일이 재발송 되었습니다."
      redirect_to "/not_activated" #이메일 인증 안내 페이지로
    else
      redirect_to root_url
    end
  end
end
