require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name can't be blank" do
    user = User.new
    user.email = "test@example.com"

    assert_equal(false, user.valid?)
    assert_equal("Name can't be blank", user.errors.full_messages[0])
  end

  test "email can't be blank" do
    user = User.new
    user.name = "Test"

    assert_equal(false, user.valid?)
    assert_equal("Email can't be blank", user.errors.full_messages[0])
  end

  test "email uniqueness" do
    user = User.new
    user.name = "John"
    user.email = "john@example.com"

    assert_equal(false, user.valid?)
    assert_equal("Email has already been taken", user.errors.full_messages[0])
  end
end
