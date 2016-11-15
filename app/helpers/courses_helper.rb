module CoursesHelper

  def all_evals
    return Evaluation.all
  end

  def all_courses
    return Course.all
  end
end
