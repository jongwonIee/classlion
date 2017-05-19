class UsersController < ApplicationController

  before_action :session_check, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(renew_password: Object))
    if @user.save
      log_in @user
      redirect_to '/signup/send_authMail' #세션이 있는 상태에서 리다이렉트
    else
      render action: 'new'
    end
  end

  def edit
    @user = @current_user
  end

  def update
    # 회원정보 수정 process
    @user = @current_user
    if @user.update_attributes(user_params)
      flash[:success] = '변경 완료!'
    else
      flash[:warning] = '어머나, 문제가 생겼어요 ㅜㅜ'
      render 'edit'
    end
  end

  # 닉네임 중복검사
  def check_nickname
    #check_email 보고 따라하셈ㅋ
  end

  # 이메일 Valiation
  def check_email
    validation = User.pre_validation_email params[:email]
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
