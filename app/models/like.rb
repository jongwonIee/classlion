class Like < ApplicationRecord

  belongs_to :course
  belongs_to :user
  has_one :evaluation

  before_create :increase_evaluation_count, :increase_user_point
  before_destroy :decrease_evaluation_count

  def increase_like_count

  end

  def decrease_like_count

  end

end
