class User < ApplicationRecord
  belongs_to :university
  belongs_to :major

  before_create :increase_user_count
  before_destroy :decrease_user_count
  before_save { self.email = email.downcase }#이메일 저장 전 소문화화

  #상수들
  #비밀번호 관련
  PASSWORD_LENGTH_MAX = 32
  PASSWORD_LENGTH_MIN = 8
  #닉네임 관련
  NICKNAME_LENGTH_MAX = 8
  NICKNAME_LENGTH_MIN = 2
  #is_impressionable

  #attr_accessor :password, :password_confirm #getter/setter
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #이메일 유효성체크
  validates :email,
    presence: { message: "입력해주세요."},
    uniqueness: { message: "이미 사용중!"},
    format: { with: VALID_EMAIL_REGEX, message: "이메일 형식확인!"},
    length: {maximum: 255}
  #닉네임 유효성체크
  validates :nickname,
    presence: { message: "입력해주세요."},
    uniqueness: { message: "이미 사용중!"},
    format: { without: /\s/, message: "공백안돼요!"}
  #닉네임 유효성체크
  validates_length_of :words_in_nickname,
    lmaximum: NICKNAME_LENGTH_MAX, minimum: NICKNAME_LENGTH_MIN,
    too_long: "닉네임은 최대 #{NICKNAME_LENGTH_MAX}자 까지 가능합니다.",
    too_short: "닉네임은 최소 #{NICKNAME_LENGTH_MIN}자 이상이어야 합니다."

  #학교 및 전공 유효성 체크
  validates_presence_of :university_id, message: "학교를 선택해주세요!"
  validates_presence_of :major_id, message: "전공을 선택해주세요!"

  has_secure_password
  validates :password,
    presence: true,
    length: { minimum: PASSWORD_LENGTH_MIN, maximum: PASSWORD_LENGTH_MAX}
  # def encrypt_password
  #   if self.password != self.password_confirm
  #     self.errors.add(:encrypt_password, "입력한 비밀번호 두개가 서로 다릅니다.")
  #     throw :abort
  #   elsif self.password.nil? or (self.password.length < PASSWORD_LENGTH_MIN)
  #     self.errors.add(:encrypt_password, "비밀번호는 #{PASSWORD_LENGTH_MIN}자 이상이어야 합니다.")
  #     throw :abort
  #   elsif self.password.length > PASSWORD_LENGTH_MAX
  #     self.errors.add(:encrypt_password, "비밀번호는 #{PASSWORD_LENGTH_MAX}자 이하여야 합니다.")
  #     throw :abort
  #   else
  #     self.encrypted_password = BCrypt::Password.create(self.password)
  #   end
  # end

  #회원가입 시, 해당 대학교의 가입 수를 확인하기 위해서 ++함
  private
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
end
