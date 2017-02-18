include ActionView::Helpers::DateHelper
class Evaluation < ApplicationRecord

  resourcify
  belongs_to :course
  belongs_to :user
  has_many :comments

  before_create :increase_evaluation_count, :increase_user_point
  before_destroy :decrease_evaluation_count

  validates :body, presence: true

  def time_ago
    #강평 작성 시간
    if (time_ago_in_words(self.created_at)) == "1분 이하"
      return '방금 전'
    elsif (time_ago_in_words(self.created_at)).last == '분' or (time_ago_in_words(self.created_at)).last == '간'
      return time_ago_in_words(self.created_at) + " 전"
    elsif (time_ago_in_words(self.created_at)).last == '일' and (time_ago_in_words(self.created_at)).chomp('일').to_i < 8
      return time_ago_in_words(self.created_at) + " 전"
    else
      return ActionController::Base.helpers.time_tag(self.created_at, :format=>'%Y년 %m월 %d일')
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
