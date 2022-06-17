require "test_helper"

class PostCommentDeleteChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe
    assert subscription.confirmed?
  end
end
