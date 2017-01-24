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
    if params[:search].nil? or (params[:search].length < 2)
      flash[:notice] = "2글자 이상 입력해주세요"
      # /evaluations로 접근하는거 막기
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
      else
        redirect_to '/'
      end

    elsif params[:search].length >= 2
      @search = Evaluation.search do
        fulltext '*' + params[:search] + '*' do
          fields(:professor, :lecture)
        end
      end
      @evaluations = @search.results
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