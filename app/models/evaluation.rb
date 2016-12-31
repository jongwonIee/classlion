class Evaluation < ApplicationRecord

  belongs_to :course
  belongs_to :user
  resourcify
  has_many :comment_of_evaluations

  before_create :increase_evaluation_count, :increase_user_point
  before_destroy :decrease_evaluation_count

  searchable do
    text :professor do
      course.professor.name
    end
    text :lecture do
      course.lecture.name
    end

  end

  private

  def increase_user_point
    user = self.user
    point = user.point + 300
    user.update_attribute(:point, point)
  end

  def increase_evaluation_count
    course = self.course
    course.update_attributes(
        evaluation_count: course.evaluation_count + 1,
        point_overall: course.point_overall + self.point_overall,
        # point_gpa_satisfaction: course.point_gpa_satisfaction + self.point_gpa_satisfaction,
        # point_easiness: course.point_easiness + self.point_easiness,
        # point_clarity: course.point_clarity + self.point_clarity
    )
    university = self.course.university
    university.update_attributes(evaluation_count: university.evaluation_count + 1)
  end

  def decrease_evaluation_count
    course = self.course
    course.update_attributes(
        evaluation_count: course.evaluation_count - 1,
        point_overall: course.point_overall - self.point_overall,
        # point_gpa_satisfaction: course.point_gpa_satisfaction - self.point_gpa_satisfaction,
        # point_easiness: course.point_easiness - self.point_easiness,
        # point_clarity: course.point_clarity + self.point_clarity
    )
    university = self.course.university
    university.update_attributes(evaluation_count: university.evaluation_count - 1)
  end

end
