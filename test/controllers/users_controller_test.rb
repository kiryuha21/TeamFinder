require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(real_name: 'Кирилл', nickname: 'kiryuha12', password_digest: '1234')
  end

  def save_and_enter
    @nickname = Faker::Name.first_name
    post users_url,
         params: { user: { nickname: @nickname, password_conf: @user.password_digest,
                           password: @user.password_digest, real_name: @user.real_name } }
    post session_create_url, params: { user: @nickname, password: @user.password_digest }
    @user = User.find_by_nickname @nickname
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      save_and_enter
    end

    assert_redirected_to games_path
  end

  test 'should show user' do
    save_and_enter
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    save_and_enter
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    save_and_enter
    patch user_url(@user),
          params: { user: { last_login: @user.last_login, nickname: @user.nickname,
                            password: @user.password_digest, real_name: @user.real_name } }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    save_and_enter
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
