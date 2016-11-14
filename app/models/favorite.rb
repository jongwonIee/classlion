class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :course
  validates_uniqueness_of :user_id, :scope => [:course_id]

  # 이거 무슨 역할하는지 궁금허다
  # def as_json(option={})
  #   super.merge(course: self.course)
  # end

end
