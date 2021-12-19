class User < ApplicationRecord
  has_secure_password

  has_many :posts

  def update_last_login
    self.last_login = DateTime.now
    save
  end
end
