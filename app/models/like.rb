class Like < ApplicationRecord
  belongs_to :user
  belongs_to :course
  validates_uniqueness_of :user_id, :scope => [:course_id]

  enum_for :state do
    value name: "unknown"
    value name: "like"
    value name: "dislike"
  end
end
