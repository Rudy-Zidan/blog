require "test_helper"

class GetAllPostsServiceTest < ActiveSupport::TestCase
  test "run" do
    posts = GetAllPostsService.new.run

    assert_equal(ActiveRecord::Relation.name, posts.class.name)
    assert_equal(1, posts.size)
  end
end