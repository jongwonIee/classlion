class CoursesController < ApplicationController
  include CoursesHelper
  before_action :set_course, only: [:show]
  before_action :goto_login, only: [:index, :show]

  def index
    if params[:search].nil? or (params[:search].split(" ").join.length < 2)
      flash[:notice] = t(:search.lack_word)
      redirect_to '/'
    else
      @search = Course.search do
        fulltext '*' + params[:search] + '*' do
          fields(:professor, :lecture)
        end
      end
      @search_param = params[:search]
      @courses = @search.results
    end
  end

  def show
    #word count
    @minimum_length = Evaluation.validators_on(:body ).first.options[:minimum]

    #evaluation
    @evaluation = Evaluation.new
    @like = Like.new

    #cancancan 수정해야함
    authorize! :show, Course

    @count = @course.evaluation_count
    @like = @course.is_like_total
    @dislike = @count - @like
    @like_per = (@like.to_f/@count).round(2)*100
    @dislike_per = (@dislike.to_f/@count).round(2)*100

    @evaluated_list = []
    @current_user.evaluations.each do |e|
      @evaluated_list << e.course_id
    end

    #dropdown filter
    @params = params[:order]
    if @params == 1
      @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    elsif @params == 2
      @evaluations = @course.evaluations.where("like.is_like = ?", true) #좋아요만
    elsif @params == 3
      @evaluations = @course.evaluations.where("like.is_like = ?", false) #싫어요만
    else
      @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    end

    #같은 강의, 연관 강의start - refactoring 가능할지..
    @related_courses = Set.new
    @identical_courses = Set.new
    Course.where("professor_id = ?", @course.professor.id).each do |course|
      @related_courses << course.id
    end

    Course.where("lecture_id = ?", @course.lecture.id).each do |lecture|
      @related_courses << lecture.id
      @identical_courses << lecture.id
    end
    #자기 자신 제외
    @related_courses.delete(params[:id].to_i)
    @identical_courses.delete(params[:id].to_i)
    #같은 강의, 연관 강의end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end
end
