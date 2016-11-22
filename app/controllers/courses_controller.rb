class CoursesController < ApplicationController
  include CoursesHelper

  def list
    @courses = all_courses
  end
end
