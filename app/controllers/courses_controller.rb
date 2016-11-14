class CoursesController < ApplicationController
  def list
    @courses = Course.all
    @evals = Evaluation.all

  end
end
