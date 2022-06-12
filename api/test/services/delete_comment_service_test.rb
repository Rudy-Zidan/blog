require "test_helper"

class DeleteCommentServiceTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @comment = comments(:one)
  end

  test "run" do
    comment = DeleteCommentService.new(comment: @comment, params: delete_comment_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(false, comment.persisted?)
  end

  test "run with different author" do
    params = delete_comment_params
    params[:user_id] = @user.id + 10
    comment = DeleteCommentService.new(comment: @comment, params: params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.any?)

    assert_equal("not authorized for this action", comment.errors[:user].first)
  end

  private

  def delete_comment_params
    {
      user_id: @user.id,
    }
  end
end