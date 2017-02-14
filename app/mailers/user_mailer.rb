class UserMailer < ApplicationMailer

  def account_activation(user)
    #인증메일 전송
    @user = user
    mail(to: user.email, subject: "[클래스라이언] 이메일을 인증해주세요!")do |format|
      format.html #형식을 html로 지정
    end
  end

  def password_reset(user)
    #비밀번호 초기화메일 전송
    @user = user
    mail(to: user.email, subject: "[클래스라이언] 비밀번호를 재설정해주세요.")do |format|
      format.html #형식을 html로 지정
    end
  end
end
