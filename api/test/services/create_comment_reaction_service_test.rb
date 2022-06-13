require "test_helper"

class CreateCommentReactionServiceTest < ActiveSupport::TestCase
  test "run" do
    comment_reaction = CreateCommentReactionService.new(**create_comment_params).run

    assert_equal(CommentReactions::LikeReaction.name, comment_reaction.class.name)
    assert_equal(true, comment_reaction.errors.empty?)
    assert_equal("CommentReactions::LikeReaction", comment_reaction.type)
  end

  test "run with duplicate reaction" do
    params = create_comment_params
    params[:user_id] = users(:one).id

    comment_reaction = CreateCommentReactionService.new(**params).run

    assert_equal(CommentReactions::LikeReaction.name, comment_reaction.class.name)
    assert_equal(true, comment_reaction.errors.any?)

    assert_equal("you already reacted in the same way before", comment_reaction.errors[:type].first)
  end

  test "run with invalid reaction" do
    comment_reaction = CreateCommentReactionService.new(**blank_params).run

    assert_equal(CommentReaction.name, comment_reaction.class.name)
    assert_equal(true, comment_reaction.errors.any?)

    assert_equal("invalid reaction, should be (like or smile or thumbs_up)", comment_reaction.errors[:reaction].first)
  end

  private

  def create_comment_params
    {
      user_id: users(:two).id,
      comment_id: comments(:one).id,
      reaction: "like",
    }
  end

  def blank_params
    {
      user_id: nil,
      comment_id: nil,
      reaction: "",
    }
  end
end