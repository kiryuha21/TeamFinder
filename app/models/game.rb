class Game < ApplicationRecord
  validates_presence_of :name

  before_save :default_values

  private

  def default_values
    self.picture_ref ||= 'default_avatar.jpg'
  end
end
