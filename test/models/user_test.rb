require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should create normal user' do
    assert User.new(real_name: 'a', nickname: 'b', password_digest: 'c').save
  end

  test 'should not create user with duplicate nickname' do
    assert_not User.new(real_name: 'a', nickname: 'kiryuha21', password_digest: 'c').save
  end
end
