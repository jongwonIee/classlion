class Wiki < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :revision, uniqueness: {  scope: :course_id,
                                    message: "only one revision per course" }

  def get_new_revision
    previous_wiki = Wiki.where(course_id: self.course_id).order('revision desc').take
    previous_number = 0
    previous_number = previous_wiki.revision if !previous_wiki.nil?
    self.revision = previous_number + 1
  end
end
