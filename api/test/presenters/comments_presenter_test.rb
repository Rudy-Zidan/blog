require "test_helper"

class CommentsPresenterTest < ActiveSupport::TestCase
  test "present" do
    comment = comments(:one)
    presenter = CommentsPresenter.new(comments: [comment])
    comments_arr = presenter.present

    assert_equal(1, comments_arr.size)
    assert_equal(%i(id content user reaction_summary), comments_arr[0].keys)
  end
end