require "test_helper"

class DeleteCommentReactionServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  def setup
    @user = users(:one)
    @comment_reaction = comment_reactions(:one)
  end

  test "run" do
    comment_reaction = DeleteCommentReactionService.new(comment_reaction: @comment_reaction, params: delete_comment_reaction_params).run

    assert_equal(CommentReactions::LikeReaction.name, comment_reaction.class.name)
    assert_equal(false, comment_reaction.persisted?)
    assert_broadcasts("delete_reaction", 1)
  end

  test "run with different author" do
    params = delete_comment_reaction_params
    params[:user_id] = @user.id + 10
    comment_reaction = DeleteCommentReactionService.new(comment_reaction: @comment_reaction, params: params).run

    assert_equal(CommentReactions::LikeReaction.name, comment_reaction.class.name)
    assert_equal(true, comment_reaction.errors.any?)

    assert_equal("not authorized for this action", comment_reaction.errors[:user].first)
    assert_broadcasts("delete_reaction", 0)
  end

  private

  def delete_comment_reaction_params
    {
      user_id: @user.id,
    }
  end
end