# frozen_string_literal: true

# model class for user
class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  validates_uniqueness_of :nickname

  validates_presence_of :nickname, :real_name

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def update_last_login
    self.last_login = DateTime.now
    save
  end
end
