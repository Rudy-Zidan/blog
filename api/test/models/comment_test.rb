require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "content can't be blank" do
    comment = Comment.new
    comment.user = users(:one)
    comment.post = posts(:one)

    assert_equal(false, comment.valid?)
    assert_equal("Content can't be blank", comment.errors.full_messages[0])
  end

  test "association must exist" do
    comment = Comment.new
    comment.content = "this is a test"

    assert_equal(false, comment.valid?)
    assert_equal("User must exist", comment.errors.full_messages[0])
    assert_equal("Post must exist", comment.errors.full_messages[1])
  end

  test "counter cache" do
    comment = comments(:two)
    like_reaction = CommentReactions::LikeReaction.create!(comment: comment, user: users(:two))
    smile_reaction = CommentReactions::SmileReaction.create!(comment: comment, user: users(:two))
    thumbs_up_reaction = CommentReactions::ThumbsUpReaction.create!(comment: comment, user: users(:two))

    assert_equal(1, comment.like_reactions_count)
    assert_equal(1, comment.smile_reactions_count)
    assert_equal(1, comment.thumbs_up_reactions_count)
  end
end
