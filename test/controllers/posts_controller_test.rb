require 'test_helper'
require_relative 'tests_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include TestsHelper
  setup do
    create_user
    save_game
    get posts_url, params: { game: @game_title }
  end

  test 'should get index' do
    get posts_url, params: { game: @game_title }
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: Faker::Game.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    create_post
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    create_post
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    create_post
    patch post_url(@post), params: { post: { body: @post.body, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post' do
    create_post
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
