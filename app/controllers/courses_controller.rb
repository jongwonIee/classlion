class CoursesController < ApplicationController
  include CoursesHelper
  before_action :activation_check

  def index
    if params[:search].nil? or (params[:search].gsub(" ","").length < 2)
      flash[:notice] = t("lack_word", scope: :search)
      redirect_back(fallback_location: root_path)
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
    @course = Course.find(params[:id])

    #render form
    @like_exists = (Like.exists?(course_id: @course.id, user_id: current_user.id))

    #word count
    @minimum_length = 100

    #evaluation
    @evaluation = Evaluation.new
    @like = Like.new

    #cancancan 수정해야함 # TODO
    authorize! :show, Course

    @evaluation_count = @course.evaluations.count
    @like_count = @course.likes.count
    @like = @course.likes.where("is_like = ?", true).count
    @dislike = @like_count - @like
    @like_per = (@like.to_f/@like_count).round(2)*100
    @dislike_per = 100 - @like_per
    # @dislike_per = (@dislike.to_f/@like_count).round(2)*100

    @evaluated_list = []
    @current_user.evaluations.each do |e|
      @evaluated_list << e.course_id
    end

    #dropdown filter
    @params = params[:order].to_i
    if @params == 1
      @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    elsif @params == 2
      @evaluations = @course.likes.where("is_like = ?", true).order(created_at: :desc).map(&:evaluation) #좋아요만
    elsif @params == 3
      @evaluations = @course.likes.where("is_like = ?", false).order(created_at: :desc).map(&:evaluation) #싫어요만
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
end
