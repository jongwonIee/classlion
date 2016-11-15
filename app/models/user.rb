require 'bcypt'
class User < ApplicationRecord
  include BCrypt

  belongs_to :university
  belongs_to :major

  before_create :encrypt_password, :increase_user_count
  before_destroy :decrease_user_count
  #상수들
  #비밀번호 관련
  PASSWORD_LENGTH_MAX = 32
  PASSWORD_LENGTH_MIN = 8
  #닉네임 관련
  NICKNAME_LENGTH_MAX = 8
  NICKNAME_LENGTH_MIN = 2
  #is_impressionable

  attr_accessor :password, :password_confirm

  #이메일 타당성체크
  validates :email,    presence: { message: "입력해주세요."},
                       uniqueness: { message: "이미 사용중!"},
                       format: { without: /\s/,
                                 message: "공백안돼요!"}
  #닉네임 타당성체크
  validates :nickname, presence: { message: "입력해주세요."},
                       uniqueness: { message: "이미 사용중!"},
                       format: { without: /\s/,
                                 message: "공백안돼요!"}
  #닉네임 길이체크
  validates_length_of :words_in_nickname,
                       maximum: NICKNAME_LENGTH_MAX,
                       minimum: NICKNAME_LENGTH_MIN,
                       too_long: "닉네임은 최대 #{NICKNAME_LENGTH_MAX}자 까지 가능합니다.",
                       too_short: "닉네임은 최소 #{NICKNAME_LENGTH_MIN}자 이상이어야 합니다."


  protected
  def encrypt_password
    if self.password != self.password_confirm
      self.errors.add(:encrypt_password, "입력한 비밀번호 두개가 서로 다릅니다.")
      throw :abort
    elsif self.password.nil? or (self.password.length < PASSWORD_LENGTH_MIN)
      self.errors.add(:encrypt_password, "비밀번호는 #{PASSWORD_LENGTH_MIN}자 이상이어야 합니다.")
      throw :abort
    elsif self.password.length > PASSWORD_LENGTH_MAX
      self.errors.add(:encrypt_password, "비밀번호는 #{PASSWORD_LENGTH_MAX}자 이하여야 합니다.")
      throw :abort
    else
      self.encrypted_password = BCrypt::Password.create(self.password)
    end
  end


  public
  def password?(password)
    BCrypt::Password.new(self.encrypt_password) == password
  end


  private
  def words_in_nickname
    nickname.strip
  end

  #회원가입 시, 해당 대학교의 가입 수를 확인하기 위해서 ++함
  def increase_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count + 1)
  end

  def decrease_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count - 1)
  end
end
