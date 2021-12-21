require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should save normal game' do
    assert Game.create(name: 'game1', creator: 'creator1')
  end

  test 'should not save empty game' do
    assert_not Game.new.save
  end
end
