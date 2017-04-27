class Like < ApplicationRecord
  belongs_to :user
  has_one :evaluation

  enum_for :state do
    value name: "unknown"
    value name: "like"
    value name: "dislike"
  end
end
