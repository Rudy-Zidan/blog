require "test_helper"

class UpdateCommentServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  def setup
    @comment = comments(:one)
  end

  test "run" do
    comment = UpdateCommentService.new(comment: @comment, params: update_comment_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.empty?)
    assert_equal("This is a test content", comment.content)
    assert_broadcasts("post_comment_update_#{@comment.post_id}", 1)
  end

  test "run with blank params" do
    comment = UpdateCommentService.new(comment: @comment, params: blank_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.any?)

    assert_equal("can't be blank", comment.errors[:content].first)
    assert_broadcasts("post_comment_update_#{@comment.post_id}", 0)
  end

  test "run with different user" do
    params = update_comment_params
    params[:user_id] += 10
    comment = UpdateCommentService.new(comment: @comment, params: params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.any?)

    assert_equal("the original post or the user are not allowed to be changed", comment.errors[:comment].first)
    assert_broadcasts("post_comment_update_#{@comment.post_id}", 0)
  end

  private

  def update_comment_params
    {
      user_id: @comment.user_id,
      post_id: @comment.post_id,
      content: "This is a test content",
    }
  end

  def blank_params
    {
      user_id:  @comment.user_id,
      post_id: @comment.post_id,
      content: "",
    }
  end
end