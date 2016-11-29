class CoursesController < ApplicationController
  include CoursesHelper

  def index
    @courses = all_courses
  end

  def show
    authorize! :show, Course
    #링크를 누르면, 애초에 그 강의의 아이디를 넘겨주는 게 나을 것 같은데
    @course = Course.find(params[:id]) #강의를 찾는다
    @evaluations = @course.evaluations #강의의 평가 가지고 오기
  end
end
