require "test_helper"

module CommentReactions
  class ThumbsUpReactionTest < ActiveSupport::TestCase
    def setup
      @comment = comments(:one)
      @user = users(:two)
    end

    test "should persist a smile reaction" do
      thumbs_up_reaction = CommentReactions::ThumbsUpReaction.new
      thumbs_up_reaction.comment = @comment
      thumbs_up_reaction.user = @user
      thumbs_up_reaction.save
  
      assert_equal(true, thumbs_up_reaction.persisted?)
      assert_equal(CommentReactions::ThumbsUpReaction.name, thumbs_up_reaction.type)
    end
  end
end