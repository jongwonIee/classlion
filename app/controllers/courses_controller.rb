class CoursesController < ApplicationController
  include CoursesHelper

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
    #evaluation
    @evaluation = Evaluation.new

    #cancancan
    authorize! :show, Course

    @course = Course.find(params[:id])
    @count = @course.evaluation_count
    @like = @course.is_like_total
    @dislike = @count - @like
    @like_per = (@like.to_f/@count).round(1)
    @dislike_per = (@dislike.to_f/@count).round(1)


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

  def favorites_add
    Favorite.create(user_id: @current_user.id, course_id: $course.id)
    redirect_to :back
  end

  def favorites_delete
    favorite = Favorite.where("user_id = ? AND course_id = ?", @current_user.id, $course.id)
    Favorite.destroy(favorite.first.id)
    redirect_to :back
  end
end
