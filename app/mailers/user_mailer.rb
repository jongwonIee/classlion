class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail(to: user.email, subject: "[클래스라이언] 이메일을 인증해주세요!")do |format|
      format.html #형식을 html로 지정
    end
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
