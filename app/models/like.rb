class Like < ApplicationRecord

  belongs_to :course
  belongs_to :user
  has_one :evaluation

end
