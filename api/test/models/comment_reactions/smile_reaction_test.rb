require "test_helper"

module CommentReactions
  class SmileReactionTest < ActiveSupport::TestCase
    def setup
      @comment = comments(:one)
      @user = users(:two)
    end

    test "should persist a smile reaction" do
      smile_reaction = CommentReactions::SmileReaction.new
      smile_reaction.comment = @comment
      smile_reaction.user = @user
      smile_reaction.save
  
      assert_equal(true, smile_reaction.persisted?)
      assert_equal(CommentReactions::SmileReaction.name, smile_reaction.type)
    end
  end
end