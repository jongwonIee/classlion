module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    #로그인
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #######다시 코드 옮기는 중
  # 넘어온 user가 current user인 경우 true를 반환한다
  def current_user?(user)
    user == current_user
  end

  #remember_token 쿠키와 일치하는 user를 반환한다
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # user가 로그인 되어 있으면 true, 그게 아니면 false
  def logged_in?
    !current_user.nil? #원래 current_user였는데 사실 @붙은거랑의 차이를 잘 모르겠고요
  end
########다시 코드 옮기는 중

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  def log_out
    #로그아웃
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil #####다시 코드 옮기는 중
  end

end
