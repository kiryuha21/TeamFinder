require 'test_helper'
require_relative 'tests_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  include TestsHelper

  setup do
    create_user
  end

  test 'should get index' do
    get games_url
    assert_response :success
  end

  test 'should get new' do
    get new_game_url
    assert_response :success
  end

  test 'should create game' do
    assert_difference('Game.count') do
      post games_url, params: { game: { name: Faker::Game.title, creator: @nickname } }
    end

    assert_redirected_to game_url(Game.last)
  end

  test 'should show game' do
    save_game
    get game_url(@game)
    assert_response :success
  end

  test 'should get edit' do
    save_game
    get edit_game_url(@game)
    assert_response :success
  end

  test 'should update game' do
    save_game
    patch game_url(@game), params: { game: { name: @game.name, creator: @game_title } }
    assert_redirected_to game_url(@game)
  end

  test 'should destroy game' do
    save_game
    assert_difference('Game.count', -1) do
      delete game_url(@game)
    end

    assert_redirected_to games_url
  end
end
