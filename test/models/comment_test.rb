require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should save normal comment' do
    user = User.create(real_name: 'rn', nickname: 'nn', password_digest: '123')
    game = Game.create(name: 'game1', creator: 'creator1')
    post = game.posts.create(title: 'hey', user_id: user.id)
    assert post.comments.new(text: 'smth', user_id: user.id).save
  end

  test 'should not save without author' do
    user = User.create(real_name: 'rn', nickname: 'nn', password_digest: '123')
    game = Game.create(name: 'game1', creator: 'creator1')
    post = game.posts.create(title: 'hey', user_id: user.id)
    assert_not post.comments.new(text: 'smth').save
  end

  test 'should not save empty' do
    assert_not Comment.new.save
  end
end
