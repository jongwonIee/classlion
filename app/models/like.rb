class Like < ApplicationRecord

  belongs_to :course
  belongs_to :user

  before_create :increase_like_count
  before_destroy :decrease_like_count

  def increase_like_count

  end

  def decrease_like_count

  end

end
