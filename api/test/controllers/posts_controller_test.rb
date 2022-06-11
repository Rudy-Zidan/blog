require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @author = users(:one)
  end

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

  test "create post" do
    post posts_url, params: create_post_payload
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("Test", res["title"])
    assert_equal("This is a test description", res["description"])
    assert_equal("This is a test content", res["content"])
  end

  test "create post with a non existing author" do
    payload = create_post_payload
    payload[:author_id] = "not-found"

    post posts_url, params: payload
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Author", res["resource"])
    assert_equal("Not found", res["message"])
  end

  test "create post with blank payload" do
    payload = create_post_payload
    payload[:title] = ""
    post posts_url, params: payload
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("title", res["errors"][0]["field"])
    assert_equal("can't be blank", res["errors"][0]["message"])
  end

  private

  def create_post_payload
    {
      title: "Test",
      content: "This is a test content",
      description: "This is a test description",
      author_id: @author.id
    }
  end
end
