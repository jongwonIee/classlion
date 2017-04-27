class CoursesController < ApplicationController
  include CoursesHelper
  before_action :set_course, only: [:show]
  before_action :goto_login, only: [:index, :show]

  def index
    if params[:search].nil? or (params[:search].split(" ").join.length < 2)
      flash[:notice] = t(:more_search_keyword)
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

    @minimum_length = Evaluation.validators_on(:body ).first.options[:minimum]

    #evaluation
    @evaluation = Evaluation.new
    @like = Like.new

    #cancancan
    authorize! :show, Course

    @count = @course.evaluation_count
    @like = @course.is_like_total
    @dislike = @count - @like
    @like_per = (@like.to_f/@count).round(2)
    @dislike_per = (@dislike.to_f/@count).round(2)

    @evaluated_list = []
    @current_user.evaluations.each do |e|
      @evaluated_list << e.course_id
    end

    #for 즐겨 찾기
    $course = Course.find(params[:id])

    #dropdown filter
    @params = params[:order]
    if @params == "최신순"
      @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    elsif @params == "총점순"
      @evaluations = @course.evaluations.order(is_like: :desc) #총점순
    elsif @params == "총점역순"
      @evaluations = @course.evaluations.order(:is_like) #총점역순
    else
      @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    end

    #같은 강의, 연관 강의
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

    @msg = "선택해주세요"
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end
end
