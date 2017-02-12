class CoursesController < ApplicationController
  include CoursesHelper

  def index
    if params[:search].nil? or (params[:search].split(" ").join.length < 2)
      flash[:notice] = t(:more_search_keyword)
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
      else
        redirect_to '/'
      end
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
    authorize! :show, Course
    #링크를 누르면, 애초에 그 강의의 아이디를 넘겨주는 게 나을 것 같은데
    @course = Course.find(params[:id]) #강의를 찾는다

    @evaluations = @course.evaluations.order(created_at: :desc) #최신순
    @evaluations_by_point = @course.evaluations.order(point_overall: :desc) #총점순
    @evaluations_by_point_desc = @course.evaluations.order(:point_overall) #총점역순

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
  end
end
