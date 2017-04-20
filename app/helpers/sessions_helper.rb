module SessionsHelper

  #------------------------------------------------------로그인/로그아웃
  # 파라미터로 넘어온 user로 로그인
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #------------------------------------------------------'기억해두기'
  # '기억해두기'체크하면 permanent세션에 유저 저장
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # '기억해두기'체크 안한경우
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #------------------------------------------------------current_user 저장 및 확인
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

  # 넘어온 user가 current user인 경우 true를 반환한다
  def current_user?(user)
    user == current_user
  end

  #------------------------------------------------------로그인 유무 확인
  def logged_in? #로그인이 된 상태란? ->current_user 세션이 있으면서, 이메일 인증이 완료된 사람
    !current_user.nil? && current_user.activated?
  end

end
