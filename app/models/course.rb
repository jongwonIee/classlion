class Course < ApplicationRecord
  has_many :evaluations
  belongs_to :lecture
  belongs_to :professor
  belongs_to :university

end
