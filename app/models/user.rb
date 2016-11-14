class User < ApplicationRecord
  belongs_to :university
  belongs_to :major

  before_create :increase_user_count
  before_destroy :decrease_user_count

  #is_impressionable

  private

  def increase_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count + 1)
  end

  def decrease_user_count
    university = self.university
    university.update_attributes(user_count: university.user_count - 1)
  end
end
