require "test_helper"

module CommentReactions
  class LikeTest < ActiveSupport::TestCase
    def setup
      @comment = comments(:one)
      @user = users(:two)
    end

    test "should persist a like reaction" do
      like_reaction = CommentReactions::Like.new
      like_reaction.comment = @comment
      like_reaction.user = @user
      like_reaction.save
  
      assert_equal(true, like_reaction.persisted?)
      assert_equal(CommentReactions::Like.name, like_reaction.type)
    end
  end
end