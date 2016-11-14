class Course < ApplicationRecord
  belongs_to :lecture
  belongs_to :professor
  belongs_to :university

end
