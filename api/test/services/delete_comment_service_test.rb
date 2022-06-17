require "test_helper"

class DeleteCommentServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  def setup
    @user = users(:one)
    @comment = comments(:one)
  end

  test "run" do
    comment = DeleteCommentService.new(comment: @comment, params: delete_comment_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(false, comment.persisted?)
    assert_broadcasts("post_comment_delete_#{@comment.post_id}", 1)
  end

  test "run with different author" do
    params = delete_comment_params
    params[:user_id] = @user.id + 10
    comment = DeleteCommentService.new(comment: @comment, params: params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.any?)

    assert_equal("not authorized for this action", comment.errors[:user].first)
    assert_broadcasts("post_comment_delete_#{@comment.post_id}", 0)
  end

  private

  def delete_comment_params
    {
      user_id: @user.id,
    }
  end
end