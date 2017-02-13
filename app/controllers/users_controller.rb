class UsersController < ApplicationController
  #layout :false

  def show
    #마이페이지로 대처? 고민해볼 것
    @user = User.find(params[:id])
  end

  def new
    #회원가입 form
    redirect_to '/main' if logged_in? #이미 로그인된 상태라면 main페이지로 리다이렉트
    @user = User.new
  end

  def create
    #회원가입 process
    user = User.new(user_params)

    if user.save
      user.send_activation_email
      redirect_to "/signup/send_authMail/#{user.email}" #이메일 인증 안내 페이지로
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    #회원정보 수정 form
    @user = User.find(params[:id])
  end

  def update
    #회원정보 수정 process
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
    #업데이트 성공시
      flash[:success] = "변경 완료!"
    else
      flash[:warning] = "어머나, 문제가 생겼어요!"
      render 'edit'
    end
  end

  #닉네임 중복검사
  def check_nickname
    puts('check_user 실행') #실행 확인용
    nickname = params[:nickname]
    user = User.where('nickname = ?', nickname).first
    if user.present? #있으면
      puts(user.nickname) #사용자 유무 확인용
      respond_to do |format|
        format.json do
          render json: {
              msg: "overlap"
          }
        end
      end
    else #없으면
      respond_to do |format|
        format.json do
          render json: {
              msg: "ok"
          }
        end
      end
    end #if문 끝
  end

  #이메일 중복검사
  def check_email
    puts('check_email 실행') #실행 확인용
    email = params[:email]
    user = User.where('email = ?', email).first
    if user.present? #있으면
      puts(user.email) #사용자 유무 확인용
      respond_to do |format|
        format.json do
          render json: {
              msg: "overlap"
          }
        end
      end
    else #없으면
      respond_to do |format|
        format.json do
          render json: {
              msg: "ok"
          }
        end
      end
    end #if문 끝
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :is_boy, :university_id,
                                 :major_id,:password, :password_confirmation)
  end
end
