require "test_helper"

class NotFoundPresenterTest < ActiveSupport::TestCase
  test "present" do
    presenter = NotFoundPresenter.new(resource: User.name)
    hash = presenter.present

    assert_equal(%i(resource message), hash.keys)
    assert_equal("User", hash[:resource])
    assert_equal("Not found", hash[:message])
  end
end