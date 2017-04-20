class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def main #최신강평 10개를 보여줌
    redirect_to '/signup/send_authMail' if !@current_user.activated? #이메일 인증이 안된경우 이메일 인증페이지로
    @evaluations = all_evaluations.limit(10)
  end

  def index #권한이 있으면, 모든 강평보여줌
    unless @current_user.has_role? :evaluator
      flash[:notice] = "권한이 없습니다!"
      redirect_to '/main'
    else
      @evaluations = all_evaluations
    end
  end

  def info
    if @current_user.has_role? :evaluator
      redirect_to '/main'
    end
  end

  def new #글작성 폼을 준다
    #자동완성에 관련된 코드
    @evaluation = Evaluation.new
    @courses = Course.all.order(:updated_at).map { |t| { :label => t.lecture.name + "(" + t.professor.name + ")", :value => t.id }}
  end

  def create #디비에 넣는다
    evaluation = Evaluation.new(eval_params)
    evaluation.user = @current_user
    if evaluation.save
      redirect_to :back
    else
      #공백이거나, space로 채운글이거나 3줄이하인 경우에 대한 에러처리 필요할 듯
      #우선 급한대로 flash
      flash[:warning] = "어머나, 문제가 생겼어요!"
      redirect_to :back
    end
  end

  private

  def eval_params
    params.require(:evaluation).permit(:user_id, :course_id, :is_like, :body)
  end

end
