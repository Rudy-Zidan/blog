require "test_helper"

class CreateCommentServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  test "run" do
    comment = CreateCommentService.new(**create_comment_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.empty?)
    assert_equal("This is a test content", comment.content)
    assert_broadcasts("post_comments_#{posts(:one).id}", 1)
  end

  test "run with blank params" do
    comment = CreateCommentService.new(**blank_params).run

    assert_equal(Comment.name, comment.class.name)
    assert_equal(true, comment.errors.any?)

    assert_equal("must exist", comment.errors[:user].first)
    assert_equal("must exist", comment.errors[:post].first)
    assert_equal("can't be blank", comment.errors[:content].first)
    assert_broadcasts("post_comments_#{posts(:one).id}", 0)
  end

  private

  def create_comment_params
    {
      user_id: users(:one).id,
      post_id: posts(:one).id,
      content: "This is a test content",
    }
  end

  def blank_params
    {
      user_id: nil,
      post_id: nil,
      content: "",
    }
  end
end