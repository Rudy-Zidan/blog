require "test_helper"

class UsersPresenterTest < ActiveSupport::TestCase
  test "present" do
    user = users(:one)
    presenter = UsersPresenter.new(users: [user])
    users_arr = presenter.present

    assert_equal(1, users_arr.size)
    assert_equal(%i(id name email), users_arr.first.keys)
  end
end