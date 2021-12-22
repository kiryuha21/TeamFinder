class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :nickname

  validates_presence_of :nickname, :real_name

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def update_last_login
    self.last_login = DateTime.now + 3.hours
    save
  end
end
