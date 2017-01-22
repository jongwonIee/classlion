class UserMailer < ActionMailer::Base
  default from: "myahn0607@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.nickname} <#{user.email}>",
        subject: "[클래스라이언] 메일을 인증해주세요!")
  end
end