class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def index
    unless current_user
      redirect_to '/home/index'
    end
    @evaluations = all_evaluations
  end

  def show

  end

  def new #글작성 폼을 준다
    #자동완성에 관련된 코드
    @evaluations = Evaluation.new
  end

  def create #디비에 넣는다
    evaluation = Evaluation.new(
        user_id: current_user.id,
        course_id: params[:course_id],
        point_overall: params[:point_overall],
        # point_easiness: params[:point_easiness],
        # point_gpa_satisfaction: params[:point_gpa_satisfaction],
        # point_clarity: params[:point_clarity],
        body: body[:body]
    )

    if evaluation.save
      @user = User.find(params[:id])
      if @user.update!(params[:point])
      redirect_to :back
      end
    else
      redirect_to "evaluations/new"
    end
  end
end
