class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments

  def update_last_login
    self.last_login = DateTime.now
    save
  end
end
