class Major < ApplicationRecord
  has_many :users
  belongs_to :university

end
