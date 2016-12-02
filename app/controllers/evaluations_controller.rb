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
  end

  def create #디비에 넣는다
    # evaluation = Evaluation.new(
    #     money: params[:money],
    #     user_id: current_user.id,
    #     course_id: params[:course_id],
    #     point_overall: params[:point_overall],
    #     # point_easiness
    #     # point_gpa_satisfaction
    #     # point_clarity
    #     body: body[:body]
    # )
    #
    # if evaluation.save
    #   redirect_to "/mypages/index"
    # else
    #   redirect_to "evaluations/new"
    # end
  end
end
