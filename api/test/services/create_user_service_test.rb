require "test_helper"

class CreateUserServiceTest < ActiveSupport::TestCase
  test "run" do
    user = CreateUserService.new(name: "test", email: "test@example.com").run

    assert_equal(User.name, user.class.name)
    assert_equal(true, user.errors.empty?)
    assert_equal("test", user.name)
    assert_equal("test@example.com", user.email)
  end

  test "run with blank params" do
    user = CreateUserService.new(name: nil, email: nil).run

    assert_equal(User.name, user.class.name)
    assert_equal(true, user.errors.any?)

    assert_equal("can't be blank", user.errors[:name].first)
    assert_equal("can't be blank", user.errors[:email].first)
  end
end