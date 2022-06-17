require "test_helper"

class PostsPresenterTest < ActiveSupport::TestCase
  test "present" do
    post = posts(:one)
    presenter = PostsPresenter.new(posts: [post])
    posts_arr = presenter.present

    assert_equal(1, posts_arr.size)
    assert_equal(%i(id author title description content published updated_at), posts_arr[0].keys)
    assert_equal("Test", posts_arr[0][:title])
    assert_equal("This is a test description", posts_arr[0][:description])
    assert_equal("This is a test content", posts_arr[0][:content])
  end
end