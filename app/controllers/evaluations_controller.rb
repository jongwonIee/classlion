class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def index
    @search = Evaluation.search do
      fulltext params[:search] do
        fields(:professor, :lecture)
      end
    end
    @evaluations = @search.results
    # unless current_user
    #   redirect_to '/home/index'
    # else
    # @evaluations = all_evaluations
    # end
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
  params.require(:evaluation).permit(:user_id, :course_id, :point_overall, :body)
  end

end