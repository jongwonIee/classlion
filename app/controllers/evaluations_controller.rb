class EvaluationsController < ApplicationController
  before_action :activation_check

  def main 

  end

  def recent
    load_limit = 2
    refresh_limit = 100
    if params[:since].nil? or params[:since].to_i == 0
      @evaluations = Evaluation.order("id desc").limit(load_limit)
    else
      @evaluations = Evaluation.where("id < ?", params[:since]).order("id desc").limit(load_limit)
      @evaluations = Array.new if params[:since].to_i < Evaluation.last.id - refresh_limit
    end
    render layout: false
  end

  def new #글작성 폼을 준다
    #자동완성에 관련된 코드
    @evaluation = Evaluation.new
    @courses = Course.all.order(:updated_at).map { |t| { :label => t.lecture.name + "(" + t.professor.name + ")", :value => t.id }}
  end

  def create #디비에 넣는다
    like = Like.where(course_id: params[:evaluation][:course_id], user_id: current_user.id).take

    evaluation = Evaluation.new(eval_params)
    evaluation.user = current_user
    evaluation.like_id = like.id
    puts like.inspect
    if evaluation.save
      user = current_user
      user.point += 200
      user.save
    else
      flash[:warning] = "문제가 생겼습니다."
    end
    redirect_to course_url(id: params[:evaluation][:course_id])
  end

  def destroy
    #after_destroy
      user = current_user
      user.point -= 200
      user.save
  end

  private

  def eval_params
    params.require(:evaluation).permit(:course_id, :body)
  end

end
