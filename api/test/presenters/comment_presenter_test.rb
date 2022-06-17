require "test_helper"

class CommentPresenterTest < ActiveSupport::TestCase
  test "present" do
    comment = comments(:one)
    presenter = CommentPresenter.new(comment: comment)
    comment_hash = presenter.present

    assert_equal(%i(id content user reaction_summary reactions created_at), comment_hash.keys)
    assert_equal(%i(id name), comment_hash[:user].keys)
    assert_equal(%i(likes smiles thumbs_up), comment_hash[:reaction_summary].keys)
    assert_equal(%i(id comment_id user_id reaction), comment_hash[:reactions].first.keys)
    assert_equal("This is a test", comment_hash[:content])
    assert_equal(10, comment_hash[:reaction_summary][:likes])
  end
end