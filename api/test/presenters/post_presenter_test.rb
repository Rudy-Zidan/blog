require "test_helper"

class PostPresenterTest < ActiveSupport::TestCase
  test "present" do
    post = posts(:one)
    presenter = PostPresenter.new(post: post)
    post_hash = presenter.present

    assert_equal(%i(id author_id title description content), post_hash.keys)
    assert_equal("Test", post_hash[:title])
    assert_equal("This is a test description", post_hash[:description])
    assert_equal("This is a test content", post_hash[:content])
  end
end