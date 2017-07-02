class Course < ApplicationRecord
  has_many :likes
  has_many :evaluations
  has_many :favorites
  has_many :wikis
  has_many :users, through: :favorites

  belongs_to :lecture
  belongs_to :professor
  belongs_to :university

  def recent_wiki
    self.wikis.order("revision desc").first
  end

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
