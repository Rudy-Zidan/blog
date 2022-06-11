require "test_helper"

class UpdatePostServiceTest < ActiveSupport::TestCase
  def setup
    @author = Author.new(users(:one).attributes)
    @post = posts(:one)
  end

  test "run" do
    post = UpdatePostService.new(post: @post, params: update_post_params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.empty?)
    assert_equal("Test", post.title)
    assert_equal(true, post.published)
  end

  test "run with blank params" do
    post = UpdatePostService.new(post: @post, params: blank_params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.any?)

    assert_equal("can't be blank", post.errors[:title].first)
    assert_equal("can't be blank", post.errors[:content].first)
    assert_equal("can't be blank", post.errors[:description].first)
  end

  test "run with different author" do
    params = update_post_params
    params[:author_id] = @author.id + 10
    post = UpdatePostService.new(post: @post, params: params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.any?)

    assert_equal("not authorized for this action", post.errors[:author].first)
  end

  private

  def update_post_params
    {
      title: "Test",
      content: "This is a test content",
      description: "This is a test description",
      author_id: @author.id,
      published: true
    }
  end

  def blank_params
    {
      title: "",
      content: "",
      description: "",
      author_id: @author.id,
    }
  end
end