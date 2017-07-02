module CoursesHelper

  def all_courses
    return Course.all.order(created_at: :desc)
  end
end
