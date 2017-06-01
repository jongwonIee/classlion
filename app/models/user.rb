class User < ApplicationRecord

  rolify

  belongs_to :university
  has_many :evaluations
  has_many :comments
  has_many :favorites
  has_many :likes
  has_many :auth_tokens
  has_many :courses, through: :favorites
  has_many :courses, through: :likes

  PASSWORD_LENGTH_MAX = 32
  PASSWORD_LENGTH_MIN = 8
  NICKNAME_LENGTH_MAX = 8
  NICKNAME_LENGTH_MIN = 2

  #Email Valiation
  attr_accessor :password, :password_confirmation, :renew_password, :skip_activation
  before_save   :encrypt_password
  before_validation :strip_information
  after_create  :send_activation_email, unless: Proc.new { self.skip_activation }

  validates :email,   format: {          with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                                         message: I18n.t("invalid_email", scope: :user)},
            uniqueness: {   message: I18n.t("email_taken", scope: :user)},
            presence: {   message: I18n.t("email_empty", scope: :user)}

  validates :nickname,  presence: {   message: I18n.t("nickname_empty", scope: :user)},
            uniqueness: {   message: I18n.t("nickname_taken", scope: :user)},
            format: {   without: /\s/,
                        message: I18n.t("invalid_nickname", scope: :user)},
            length: {   maximum: NICKNAME_LENGTH_MAX,
                        minimum: NICKNAME_LENGTH_MIN,
                        too_long: I18n.t("nickname_too_long",  max: NICKNAME_LENGTH_MAX, scope: :user),
                        too_short: I18n.t("nickname_too_short", min: NICKNAME_LENGTH_MIN, scope: :user)}

  validates :password_confirmation,    unless: Proc.new { self.renew_password.nil? },
            presence: {  message: I18n.t("password_empty", scope: :user)}

  validates :university_id, presence: { message: I18n.t("invalid_university", scope: :user)}

  validates :password,       unless: Proc.new { self.renew_password.nil? },
            confirmation: { case_sensitive: true,
                            message: I18n.t("password_mismatch", scope: :user)},
            presence: { message: I18n.t("password_empty", scope: :user)},
            length: { maximum: PASSWORD_LENGTH_MAX,
                      minimum: PASSWORD_LENGTH_MIN,
                      too_long: I18n.t("password_too_long",  max: PASSWORD_LENGTH_MAX, scope: :user),
                      too_short: I18n.t("password_too_short", min: PASSWORD_LENGTH_MIN, scope: :user)}


  #인증
  def activate(auth_token)
    if auth_token.created_at > 3.hours.ago #3시간 이내면
      update_columns(activated: true, activated_at: Time.zone.now) #활성화
      return true
    else
      return false
    end
  end

  def activated?
    self.activated
  end

  #로그인상태 유지 관련 -------------------------------------------------
  def authenticated?(cookie)
    BCrypt::Password.new(self.remember_digest).is_password?(cookie)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, BCrypt::Password.create(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  #Favorites
  def favorites_addition(user_id, course_id)
    Favorite.create(user_id: user_id, course_id: course_id)
  end

  def favorites_deletion(user_id, course_id)
    favorite = Favorite.where('user_id = ? AND course_id = ?', user_id, course_id)
    Favorite.destroy(favorite.first.id)
  end

  #Likes
  def is_like_creation(user_id, course_id, boolean)
    Like.create(user_id: user_id, course_id: course_id, is_like: boolean)
  end

  #Updating Likes
  def is_like_updation(user_id, course_id, boolean)
    like = Like.where('user_id = ? AND course_id = ?', user_id, course_id)
    Like.update(like.first.id, is_like: boolean)
  end

  def is_like_deletion(user_id, course_id)
    like = Like.where('user_id = ? AND course_id = ?', user_id, course_id)
    Like.destroy(like.first.id)
  end

  def password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def send_activation_email
    at = AuthToken.create(user: self, auth_type: 1, token: SecureRandom.uuid.gsub("-", ""))
    UserMailer.account_activation(self, at).deliver_now
  end


  #------------------------------------------------------이메일, 비밀번호 및 닉네임 중복 확인
  #이메일 중복 확인
  def self.pre_validation_email(email)
    if valid_email? email #이메일 형식이 맞고
      if User.where(email: email).present? #사용자가 있으면
        { message: '이미 사용 중인 이메일 입니다.', status: :bad_request}
      else #사용자가 없으면
        { message: '사용가능', status: :ok }
      end
    elsif email == '' #이메일이 비어있으면
      { message: '필수정보입니다.', status: :bad_request }
    else
      { message: '이메일 형식을 확인해주세요.', status: :bad_request }
    end
  end

  #비밀번호 길이 확인
  def self.pre_validation_password_length(password, password_confirmation) #'비밀번호'가 오면
    if password == '' #비밀번호가 비어있으면
      { message: '필수정보입니다.', status: :bad_request }
    elsif (password.length >= 8) && (password.length <= 32)
      if password == password_confirmation
        { message: '일치함', status: :ok }
      elsif password_confirmation != ''
        { message: '두 비밀번호가 일치하지 않습니다.', status: :bad_request }

      end
    else
      { message: '비밀번호는 8자이상 32자 이하만 가능합니다.', status: :bad_request }
    end
  end

  #닉네임 중복 확인
  def self.pre_validation_nickname(nickname)
    if valid_nickname? nickname #닉네임 형식이 맞으면
      if User.where(nickname: nickname).present? #해당 닉네임을 가진 사용자가 있으면
        { message: '이미 사용중인 닉네임입니다.', status: :bad_request }
      else
        { message: '사용가능', status: :ok }
      end
    else #닉네임 형식이 맞지않으면
      { message: '닉네임은 2자이상 8자이하여야 합니다.', status: :bad_request }
    end
  end

  #------------------------------------------------------이메일, 비밀번호 및 닉네임 형식확인
  #이메일 형식 확인
  def self.valid_email? email
    (email =~ VALID_EMAIL_REGEX)
  end

  #닉네임 형식 확인
  def self.valid_nickname? nickname
    if (nickname.length >= 2) && (nickname.length <= 8)
      true
    else
      false
    end
  end

  private
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def strip_information
    self.nickname.strip!
    self.email.strip!
    self.email = email.downcase
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(self.password) unless self.renew_password.nil?
  end

end

