require "test_helper"

class DeletePostServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  def setup
    @author = Author.new(users(:one).attributes)
    @post = posts(:one)
  end

  test "run" do
    post = DeletePostService.new(post: @post, params: delete_post_params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(false, post.persisted?)
    assert_broadcasts('delete_post', 1)
  end

  test "run with different author" do
    params = delete_post_params
    params[:author_id] = @author.id + 10
    post = DeletePostService.new(post: @post, params: params).run

    assert_equal(Post.name, post.class.name)
    assert_equal(true, post.errors.any?)

    assert_equal("not authorized for this action", post.errors[:author].first)
    assert_broadcasts('delete_post', 0)
  end

  private

  def delete_post_params
    {
      author_id: @author.id,
    }
  end
end