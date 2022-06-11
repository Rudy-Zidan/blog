require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "title can't be blank" do
    post = Post.new
    post.description = "This is a test description"
    post.content = "This is a test content"
    post.author = @user

    assert_equal(false, post.valid?)
    assert_equal("Title can't be blank", post.errors.full_messages[0])
  end

  test "description can't be blank" do
    post = Post.new
    post.title = "This is a test title"
    post.content = "This is a test content"
    post.author = @user

    assert_equal(false, post.valid?)
    assert_equal("Description can't be blank", post.errors.full_messages[0])
  end

  test "content can't be blank" do
    post = Post.new
    post.title = "This is a test title"
    post.description = "This is a test description"
    post.author = @user

    assert_equal(false, post.valid?)
    assert_equal("Content can't be blank", post.errors.full_messages[0])
  end

  test "author must exist" do
    post = Post.new
    post.title = "This is a test title"
    post.description = "This is a test description"
    post.content = "This is a test content"

    assert_equal(false, post.valid?)
    assert_equal("Author must exist", post.errors.full_messages[0])
  end
end
