require "test_helper"

class AuthorPresenterTest < ActiveSupport::TestCase
  test "present" do
    author = Author.new(users(:one).attributes)
    presenter = AuthorPresenter.new(author: author)
    author_hash = presenter.present

    assert_equal(%i(id name email), author_hash.keys)
    assert_equal("John", author_hash[:name])
  end
end