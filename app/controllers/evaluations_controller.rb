class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def main
    unless current_user
      redirect_to '/'
    else
      @evaluations = all_evaluations.limit(10)
    end
  end

  def info
    user = User.find(current_user.id)
    if user.has_role? :evaluator
      redirect_to '/main'
    end
  end

  def index
    unless params[:search].blank?
      @search = Evaluation.search do
        fulltext params[:search] do
          fields(:professor, :lecture)
        end
      end
      @evaluations = @search.results
    else #/evaluations로 타고 들어왔을 때 어떻게???? 나중에 front붙으면서 달라질 부분일듯 -우리
        @evaluations = all_evaluations
    end
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