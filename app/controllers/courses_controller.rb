class CoursesController < ApplicationController
  include CoursesHelper

  def index
    @evaluations = all_evals
  end

  def list
    @courses = all_courses
  end
end
