class State < ApplicationRecord
  has_many :hikes
  has_many :users, through: :hikes

end
