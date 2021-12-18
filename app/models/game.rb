class Game < ApplicationRecord
  has_one_attached :image

  validates_presence_of :name, :creator
end
