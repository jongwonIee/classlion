module SessionsHelper

  def log_in(user)
    #로그인
    session[:user_id] = user.id
  end

  def current_user
    #현재 유저가 누군지
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    #로그인 되어있는지 확인
    !current_user.nil?
  end

  def log_out
    #로그아웃
    log_out
    redirect_to root_url
  end
end
