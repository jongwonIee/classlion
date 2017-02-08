class Course < ApplicationRecord
  has_many :evaluations
  belongs_to :lecture
  belongs_to :professor
  belongs_to :university

  #solr
  searchable do
    text :professor do
      self.professor.name
    end
    text :lecture do
      self.lecture.name
    end
  end

end
