class Course < ApplicationRecord
  has_many :evaluations
  belongs_to :lecture
  belongs_to :professor
  belongs_to :university
  has_many :favorites
  has_many :users, through: :favorites

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
