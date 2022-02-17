require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def create_user
    @user = User.new(real_name: 'Кирилл', nickname: 'kiryuha12', password_digest: '1234')
    @nickname = Faker::Name.first_name
    post users_url,
         params: { user: { nickname: @nickname, password_conf: @user.password_digest,
                           password: @user.password_digest, real_name: @user.real_name } }
    post session_create_url, params: { user: @nickname, password: @user.password_digest }
    @user = User.find_by_nickname @nickname
  end

  def save_game
    @game_title = Faker::Game.title
    post games_url, params: { game: { name: @game_title, creator: @nickname } }
    @game = Game.find_by_name @game_title
  end

  def create_post
    @post_title = Faker::Game.title
    post posts_url, params: { post: { title: @post_title } }
    @post = Post.find_by_title @post_title
  end

  setup do
    create_user
    save_game
    get posts_url, params: { game: @game_title }
    create_post
    get comments_url, params: { post: @post.id }
  end

  def create_comment
    @text = Faker::Lorem.word
    post comments_url, params: { comment: { text: @text } }
    @comment = Comment.find_by_text @text
  end

  test 'should get index' do
    get comments_url
    assert_response :success
  end

  test 'should get new' do
    get new_comment_url
    assert_response :success
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { text: Faker::Lorem.word } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test 'should show comment' do
    create_comment
    get comment_url(@comment)
    assert_response :success
  end

  test 'should get edit' do
    create_comment
    get edit_comment_url(@comment)
    assert_response :success
  end

  test 'should update comment' do
    create_comment
    patch comment_url(@comment),
          params: { comment: { author: @comment.author, text: @comment.text } }
    assert_redirected_to comments_url
  end

  test 'should destroy comment' do
    create_comment
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
