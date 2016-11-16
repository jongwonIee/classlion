class CoursesController < ApplicationController
  include CoursesHelper

  def index
    @courses = all_courses
  end

end
