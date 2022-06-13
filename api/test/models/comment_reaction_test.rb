require "test_helper"

class CommentReactionTest < ActiveSupport::TestCase
  test "association must exist" do
    comment_reaction = CommentReaction.new
    comment_reaction.valid?

    assert_equal(false, comment_reaction.valid?)
    assert_equal("Comment must exist", comment_reaction.errors.full_messages[0])
    assert_equal("User must exist", comment_reaction.errors.full_messages[1])
  end

  test "reaction uniqueness" do
    comment_reaction = CommentReaction.new
    comment_reaction.comment = comments(:one)
    comment_reaction.user = users(:one)
    comment_reaction.type = CommentReactions::LikeReaction.name

    assert_equal(false, comment_reaction.valid?)
    assert_equal("you already reacted in the same way before", comment_reaction.errors[:type][0])
  end
end
