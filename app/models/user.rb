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
  after_create  :send_activaion_email, unless: Proc.new { self.skip_activation }

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

  validates :password_confirmation,    unless: "renew_password.nil?",
                                     presence: {  message: I18n.t("password_empty", scope: :user)}

  validates :university_id, presence: { message: I18n.t("invalid_university", scope: :user)}

  validates :password,       unless: "renew_password.nil?",
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
    end
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
          
  def self.pre_validation_email(email)
    if true #여기다가 이메일 validation 추가하면 됨. email regex + 중복검사 + 특수문자 검사등
      { message: I18n.t("valid_email", scope: :user), status: :ok }
    else
      { message: I18n.t("invalid_email", scope: :user), status: :bad_request }
    end
  end

  def password?(password)
    BCrypt::Password.new(self.password_digest) == password
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

  def send_activaion_email
    at = AuthToken.create(user: self, auth_type: 1, token: SecureRandom.uuid.gsub("-", ""))
    UserMailer.account_activation(self, at).deliver_now
  end
end

