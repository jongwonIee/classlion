class Evaluation < ApplicationRecord

  belongs_to :course
  belongs_to :user
  resourcify
  has_many :comments

  before_create :increase_evaluation_count, :increase_user_point
  before_destroy :decrease_evaluation_count

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
        point_overall_sum: course.point_overall_sum + self.point_overall,
        point_gpa_satisfaction_sum: course.point_gpa_satisfaction_sum + self.point_gpa_satisfaction,
        point_easiness_sum: course.point_easiness_sum + self.point_easiness,
        point_clarity_sum: course.point_clarity_sum + self.point_clarity
    )
    university = self.course.university
    university.update_attributes(evaluation_count: university.evaluation_count + 1)
  end

  def decrease_evaluation_count
    course = self.course
    course.update_attributes(
        evaluation_count: course.evaluation_count - 1,
        point_overall_sum: course.point_overall_sum - self.point_overall,
        point_gpa_satisfaction_sum: course.point_gpa_satisfaction_sum - self.point_gpa_satisfaction,
        point_easiness_sum: course.point_easiness_sum - self.point_easiness,
        point_clarity_sum: course.point_clarity_sum - self.point_clarity
    )
    university = self.course.university
    university.update_attributes(evaluation_count: university.evaluation_count - 1)
  end

end
