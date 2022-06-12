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
end
