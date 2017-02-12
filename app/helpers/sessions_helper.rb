module SessionsHelper

  def log_in(user)
    #로그인
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out(user)
    #로그아웃
    forget(user)
    session.delete(:user_id)
  end

end
