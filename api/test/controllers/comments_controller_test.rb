require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create post" do
    post comments_url, params: create_comment_payload
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("This is a test", res["content"])
    assert_equal("John", res["user"]["name"])
  end

  test "create post with a non existing author" do
    post comments_url, params: {}
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(3, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("user", res["errors"][0]["field"])
    assert_equal("must exist", res["errors"][0]["message"])

    assert_equal("post", res["errors"][1]["field"])
    assert_equal("must exist", res["errors"][1]["message"])

    assert_equal("content", res["errors"][2]["field"])
    assert_equal("can't be blank", res["errors"][2]["message"])
  end

  private

  def create_comment_payload
    {
      post_id: posts(:one).id,
      user_id: users(:one).id,
      content: "This is a test"
    }
  end
end
