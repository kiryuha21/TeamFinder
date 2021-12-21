require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should save normal post' do
    user = User.create(real_name: 'rn', nickname: 'nn', password_digest: '123')
    game = Game.create(name: 'game1', creator: 'creator1')
    assert game.posts.new(title: 'hey', user_id: user.id).save
  end

  test 'should save post without author' do
    game = Game.create(name: 'game1', creator: 'creator1')
    assert_not game.posts.new(title: 'hey').save
  end

  test 'should save empty post' do
    game = Game.create(name: 'game1', creator: 'creator1')
    assert_not game.posts.new.save
  end
end
