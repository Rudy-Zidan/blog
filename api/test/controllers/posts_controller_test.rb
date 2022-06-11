require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "get post by id" do
    post = posts(:one)
    get post_url(post.id)
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("Test", res["title"])
    assert_equal("This is a test description", res["description"])
    assert_equal("This is a test content", res["content"])
  end

  test "get post by not found id" do
    get post_url("not-found")
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Post", res["resource"])
    assert_equal("Not found", res["message"])
  end
end
