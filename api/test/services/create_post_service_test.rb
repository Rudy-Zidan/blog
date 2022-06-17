require "test_helper"
# require "ActionCable::TestHelper"

class CreatePostServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  def setup
    @author = Author.new(users(:one).attributes)
  end

  test "run" do
    post = CreatePostService.new(**create_post_params).run
    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.empty?)
    assert_equal("Test", post.title)
    assert_broadcasts('post', 1)
  end

  test "run with blank params" do
    post = CreatePostService.new(**blank_params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.any?)

    assert_equal("can't be blank", post.errors[:title].first)
    assert_equal("can't be blank", post.errors[:content].first)
    assert_equal("can't be blank", post.errors[:description].first)

    assert_broadcasts('post', 0)
  end

  private

  def create_post_params
    {
      title: "Test",
      content: "This is a test content",
      description: "This is a test description",
      author: @author
    }
  end

  def blank_params
    {
      title: "",
      content: "",
      description: "",
      author: @author
    }
  end
end