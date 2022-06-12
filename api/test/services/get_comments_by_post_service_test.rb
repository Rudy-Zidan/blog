require "test_helper"

class GetCommentsByPostServiceTest < ActiveSupport::TestCase
  test "run" do
    post = posts(:one)
    comments = GetCommentsByPostService.new(post: post).run

    assert_equal(ActiveRecord::AssociationRelation.name, comments.class.name)
    assert_equal(1, comments.size)
  end

  test "run with nil post" do
    comments = GetCommentsByPostService.new(post: nil).run

    assert_equal(ActiveRecord::Relation.name, comments.class.name)
    assert_equal(0, comments.size)
  end
end