class Comment < ApplicationRecord
  belongs_to :evaluation
  belongs_to :user
end
