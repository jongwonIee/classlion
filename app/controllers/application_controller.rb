class ApplicationController < ActionController::Base
  include Mobvious::Rails::Controller
  include SessionsHelper #여기에 로그인, 로그아웃, current_user와 관련된 코드가 있음
  protect_from_forgery with: :exception
  before_action :set_locale

  def session_check
    if !logged_in?
      flash[:warning] = t("role.user.goto_login")
      redirect_to login
    end
  end

  def activation_check
    if !logged_in? 
      if !current_user.activated?
        flash[:warning] = "인증이 되지 않았습니다."
        redirect_to not_activated
      else
        flash[:warning] = t("role.user.goto_login")
        redirect_to login
      end
    end
  end

  #returns false unless mobile
  def mobile_check
    for_device_type :mobile do
      @is_mobile = true
    end
  end

  private


  # i18n
  # Before every request, we set the locale, from the specified or detected settings, or from the cookie
  def set_locale
    if language_change_necessary?
      I18n.locale = the_new_locale
      set_locale_cookie(I18n.locale)
    else
      use_locale_from_cookie
    end
  end

  # A locale change is necessary if no locale cookie is found, or if the locale param has been specified
  def language_change_necessary?
    return cookies['locale'].nil? || params[:locale]
  end

  # The new locale is taken from the current_user language setting, it logged_in, or from the http accept language header if not
  # In both cases, if a locale param has been passed, it takes precedence. Only available locales are accepted
  def the_new_locale
    new_locale = (params[:locale] || extract_locale_from_accept_language_header)
    ['en', 'ko'].include?(new_locale) ? new_locale : I18n.default_locale.to_s
  end

  # Sets the locale cookie
  def set_locale_cookie(locale)
    cookies['locale'] = locale.to_s
  end

  # Reads the locale cookie and sets the locale from it
  def use_locale_from_cookie
    I18n.locale = cookies['locale']
  end

  # Extracts the locale from the accept language header, if found
  def extract_locale_from_accept_language_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first rescue I18n.default_locale
  end

end
