require "test_helper"

class CommentReactionPresenterTest < ActiveSupport::TestCase
  test "present" do
    comment_reaction = comment_reactions(:one)
    presenter = CommentReactionPresenter.new(comment_reaction: comment_reaction)
    comment_reaction_hash = presenter.present

    assert_equal(%i(id comment_id user_id reaction), comment_reaction_hash.keys)
    assert_equal("like", comment_reaction_hash[:reaction])
  end
end