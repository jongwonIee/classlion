class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def main
    unless current_user
      redirect_to '/home/index'
    end
    @evaluations = all_evaluations.limit(10)
  end

  def info
    user = User.find(current_user.id)
    if user.has_role? :evaluator
      redirect_to '/main'
    end
  end

  def index
    @search = Evaluation.search do
      fulltext params[:search] do
        fields(:professor, :lecture)
      end
    end
    @evaluations = @search.results
  end

  def show

  end

  def new #글작성 폼을 준다
    #자동완성에 관련된 코드
    @evaluation = Evaluation.new
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