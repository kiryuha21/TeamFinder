require 'test_helper'
require_relative 'tests_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  include TestsHelper
  test 'should get login' do
    get session_login_url
    assert_response :success
  end

  test 'should get welcome_page' do
    get session_welcome_page_url
    assert_response :success
  end

  test 'should get create' do
    create_user
    assert_redirected_to games_path
  end

  test 'should get logout' do
    get session_logout_url
    assert_redirected_to session_login_url
  end
end
