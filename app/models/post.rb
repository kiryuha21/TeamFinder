class Post < ApplicationRecord
  validates_presence_of :title

  belongs_to :game
  belongs_to :user

  has_many :comments

  has_rich_text :body
end
