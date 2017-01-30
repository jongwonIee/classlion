class CoursesController < ApplicationController
  include CoursesHelper

  def index
    # @courses = all_courses
    if params[:search].nil? or (params[:search].length < 2)
      flash[:notice] = "2글자 이상 입력해주세요"
      # /evaluations로 접근하는거 막기 -> course index로 바꾸면서 의미가 없는 것 같은데 체크 바람!!!
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
      else
        redirect_to '/'
      end
    elsif params[:search].length >= 2
      @search = Course.search do
        fulltext '*' + params[:search] + '*' do
          fields(:professor, :lecture)
        end
      end

      @search_param = params[:search]
      @courses = @search.results
    end

    #count logic
    @lecture_count = 0
    @professor_count = 0
    @courses.each do |c|
      if c.lecture.name.nil? or c.lecture.name != @lecture_name
        @lecture_count += 1
        @lecture_name = c.lecture.name
        @previous_course = c
      elsif c.lecture.name == @lecture_name and c.is_major != @previous_course.is_major
        @lecture_count += 1
        @lecture_name = c.lecture.name
        @previous_course = c
      end
      if c.professor.name.nil? or c.professor.name != @professor_name
        @professor_count += 1
        @professor_name = c.professor.name
      end
    end
  end

  def show
    authorize! :show, Course
    #링크를 누르면, 애초에 그 강의의 아이디를 넘겨주는 게 나을 것 같은데
    @course = Course.find(params[:id]) #강의를 찾는다
    @evaluations = @course.evaluations.order(created_at: :desc) #강의의 평가 가지고 오기
    # @time = time_diff(Time.now, Time.now-2.days-3.hours-4.minutes-5.seconds)
  end
end