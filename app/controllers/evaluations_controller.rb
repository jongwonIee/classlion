class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def main #최신강평 10개를 보여줌
    @evaluations = all_evaluations.limit(10)
  end

  def index #권한이 있으면, 모든 강평보여줌
    unless current_user.has_role? :evaluator
      flash[:notice] = "권한이 없습니다!"
      redirect_to '/main'
    else
      @evaluations = all_evaluations
    end
  end

  def info
    if current_user.has_role? :evaluator
      redirect_to '/main'
    end
  end

  def show

  end

  def new #글작성 폼을 준다
    #자동완성에 관련된 코드
    @evaluation = Evaluation.new

    @courses = Course.all
  end

  def create #디비에 넣는다
    evaluation = Evaluation.new(eval_params)
    if evaluation.save
      redirect_to "/"
    else
      redirect_to :back
    end
  end

  private
  def eval_params
  params.require(:evaluation).permit(:user_id, :course_id, :point_overall, :point_easiness, :point_gpa_satisfaction, :point_clarity, :body)
  end

end
