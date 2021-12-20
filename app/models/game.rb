class Game < ApplicationRecord
  has_one_attached :image

  has_many :posts, dependent: :destroy

  validates_presence_of :name, :creator
end
