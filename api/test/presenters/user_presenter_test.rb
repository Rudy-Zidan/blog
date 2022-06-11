require "test_helper"

class UserPresenterTest < ActiveSupport::TestCase
  test "present" do
    user = users(:one)
    presenter = UserPresenter.new(user: user)
    user_hash = presenter.present

    assert_equal(%i(id name email), user_hash.keys)
    assert_equal("John", user_hash[:name])
  end
end