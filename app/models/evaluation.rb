class Evaluation < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :comment_of_evaluations

  before_create :increase_evaluation_count, :decrease_user_mandatory_evaluation_count
  before_destroy :decrease_evaluation_count


  private

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

  def decrease_user_mandatory_evaluation_count
    user = self.user
    user.mandatory_evaluation_count = user.mandatory_evaluation_count - 1 if user.mandatory_evaluation_count > 0
    user.save
  end
end
