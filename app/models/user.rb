class User < ApplicationRecord
  rolify
  belongs_to :university
  has_many :evaluations
  has_many :comments
  has_many :favorites
  has_many :courses, through: :favorites
  has_many :likes
  has_many :courses, through: :likes

  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :increase_user_count, :create_activation_digest
  before_destroy :decrease_user_count
  before_save :downcase_email #이메일 저장 전 소문화화

  #상수들
  #비밀번호 관련
  PASSWORD_LENGTH_MAX = 32
  PASSWORD_LENGTH_MIN = 8
  #닉네임 관련
  NICKNAME_LENGTH_MAX = 8
  NICKNAME_LENGTH_MIN = 2
  #is_impressionable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #이메일 유효성체크
  validates :email,
    presence: { message: '이메일을 입력해주세요.'}, uniqueness: { message: '이미 사용중인 이메일입니다.'},
    format: { with: VALID_EMAIL_REGEX, message: '이메일 형식을 확인해주세요.'},
    length: {maximum: 255}
  #닉네임 유효성체크
  validates :nickname,
    presence: { message: '닉네임을 입력해주세요.'},
    uniqueness: { message: '이미 사용중인 닉네임입니다.'},
    format: { without: /\s/, message: '닉네임에는 공백을 사용할 수 없습니다.'}
  #닉네임 유효성체크
  validates_length_of :words_in_nickname,
    maximum: NICKNAME_LENGTH_MAX, minimum: NICKNAME_LENGTH_MIN,
    too_long: "닉네임은 최대 #{NICKNAME_LENGTH_MAX}자 까지 가능합니다.",
    too_short: "닉네임은 최소 #{NICKNAME_LENGTH_MIN}자 이상이어야 합니다."

  #학교 및 전공 유효성 체크
  validates_presence_of :university_id, message: '학교를 선택해주세요.'

  has_secure_password
  validates :password,
    presence: true
    # length: { minimum: PASSWORD_LENGTH_MIN, maximum: PASSWORD_LENGTH_MAX}

  validates_length_of :password,
    maximum: PASSWORD_LENGTH_MAX, minimum: PASSWORD_LENGTH_MIN,
    too_long: "비밀번호는 최대 #{PASSWORD_LENGTH_MAX}자 까지 가능합니다.",
    too_short:  "비밀번호는 최소 #{PASSWORD_LENGTH_MIN}자 이상이어야 합니다."

  #보안토큰 관련 -------------------------------------------------
  #주어진 문자열에 대해서 hash digest를 반환
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #random token 반환
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  #로그인상태 유지 관련 -------------------------------------------------
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  #인증메일 & 비밀번호 초기화 관련 -------------------------------------------------
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    #이메일 인증 후 계정 활성화
    if activation_sent_at > 3.hours.ago #3시간 이내면
      update_columns(activated: true, activated_at: Time.zone.now) #활성화
    end
  end

  def send_activation_email
    #인증 이메일 전송
    if UserMailer.account_activation(self).deliver_now
      update_attribute(:activation_sent_at, Time.zone.now)# 전송이 잘 되면 현재 시간 저장
    end
  end

  def resend_activation_email
    #인증메일 재전송
    self.send :recreate_activation_digest
  end

  #------------------------------------------------------비밀번호
  def create_reset_digest
    #비밀번호 초기화
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    #비밀번호 초기화 이메일 전송
    UserMailer.password_reset(self).deliver_now
  end

  #비밀번호 초기화 이메일 유효시간 체크
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  #------------------------------------------------------즐겨찾기 및 강평 좋아요
  #즐찾
  def favorites_addition(user_id, course_id)
    Favorite.create(user_id: user_id, course_id: course_id)
  end

  def favorites_deletion(user_id, course_id)
    favorite = Favorite.where('user_id = ? AND course_id = ?', user_id, course_id)
    Favorite.destroy(favorite.first.id)
  end

  #좋아요
  def is_like_creation(user_id, course_id, boolean)
    Like.create(user_id: user_id, course_id: course_id, is_like: boolean)
  end

  #updation이라는 단어는 없지만 포맷통일을 위해..
  def is_like_updation(user_id, course_id, boolean)
    like = Like.where('user_id = ? AND course_id = ?', user_id, course_id)
    Like.update(like.first.id, is_like: boolean)
  end

  def is_like_deletion(user_id, course_id)
    like = Like.where('user_id = ? AND course_id = ?', user_id, course_id)
    Like.destroy(like.first.id)
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

  def downcase_email
    self.email = email.downcase
  end

  def increase_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count + 1)
  end

  def decrease_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count - 1)
  end

  def words_in_nickname
    nickname.strip
  end

  def create_activation_digest
    #token & digest 생성
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def recreate_activation_digest
    #token & digest 재생성
    self.activation_token = User.new_token
    update_columns(activation_digest: User.digest(activation_token))
  end
end

