class UsersController < ApplicationController
  before_action :goto_main, only: [:new]
  before_action :goto_login, only: [:edit]
  # before_action :correct_user,   only: [:edit, :update]

  def new
    # 회원가입 form
    @user = User.new
  end

  def create
    # 회원가입 process
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      log_in @user
      redirect_to '/signup/send_authMail' #세션이 있는 상태에서 리다이렉트
    else
      render action: 'new'
    end
  end

  def edit
    # 회원정보 수정 form
    #@user = User.find(params[:id])
    @user = @current_user
  end

  def update
    # 회원정보 수정 process
    @user = @current_user
    if @user.update_attributes(user_params)
    # 업데이트 성공시
      flash[:success] = '변경 완료!'
    else
      flash[:warning] = '어머나, 문제가 생겼어요 ㅜㅜ'
      render 'edit'
    end
  end

  # 이메일 가능여부 확인
  def check_email
    validation = User.pre_validation_email params[:email]
    render json: { message: validation[:message] }, status: validation[:status]
  end

  #비밀번호 길이 확인
  def check_password
    validation = User.pre_validation_password_length(params[:password], params[:password_confirmation])
    render json: { message: validation[:message] }, status: validation[:status]
  end

  # 닉네임 중복검사
  def check_nickname
    validation = User.pre_validation_nickname params[:nickname]
    render json: { message: validation[:message] }, status: validation[:status]
  end

  # 관심강의 추가/제거
  def favorites_add
    if current_user.favorites_addition(current_user.id, params[:c_id].to_i)
      render json: { msg: 'ok'}
    else
      render json: { msg: 'error'}
    end
  end

  def favorites_delete
    if current_user.favorites_deletion(current_user.id, params[:c_id].to_i)
      render json: { msg: 'ok'}
    else
      render json: { msg: 'error'}
    end
  end

  # 좋아요
  def is_like_create
    if current_user.is_like_creation(current_user.id, params[:c_id].to_i, params[:boolean])
      render json: { msg: 'ok'}
    else
      render json: { msg: 'error'}
    end
  end

  def is_like_update
    if current_user.is_like_updation(current_user.id, params[:c_id].to_i, params[:boolean])
      render json: { msg: 'ok'}
    else
      render json: { msg: 'error'}
    end
  end

  def is_like_delete
    if current_user.is_like_deletion(current_user.id, params[:c_id].to_i)
      render json: { msg: 'ok'}
    else
      render json: { msg: 'error'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :is_boy, :university_id,
                                 :password, :password_confirmation)
  end

end
