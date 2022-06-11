require "test_helper"

class GetPostsByAuthorServiceTest < ActiveSupport::TestCase
  test "run" do
    posts = GetPostsByAuthorService.new(author: users(:one)).run

    assert_equal(ActiveRecord::Associations::CollectionProxy.name, posts.class.name)
    assert_equal(1, posts.size)
  end

  test "run with nil author" do
    posts = GetPostsByAuthorService.new(author: nil).run

    assert_equal(ActiveRecord::Relation.name, posts.class.name)
    assert_equal(0, posts.size)
  end
end