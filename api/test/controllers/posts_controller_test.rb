require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @author = Author.new(users(:one).attributes)
    @post = posts(:one)
  end

  test "get post by id" do
    get post_url(@post.id)
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

  test "update post" do
    put post_url(@post.id), params: update_post_payload
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("Test", res["title"])
    assert_equal("This is a test description", res["description"])
    assert_equal("This is a test content", res["content"])
    assert_equal(true, res["published"])
  end

  test "update post with blank payload" do
    params = update_post_payload
    params[:title] = ""

    put post_url(@post.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("title", res["errors"][0]["field"])
    assert_equal("can't be blank", res["errors"][0]["message"])
  end

  test "update post with different author" do
    params = update_post_payload
    params[:author_id] = @post.author_id + 10

    put post_url(@post.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("author", res["errors"][0]["field"])
    assert_equal("not authorized for this action", res["errors"][0]["message"])
  end

  test "update post by not found id" do
    put post_url("not-found"), params: update_post_payload
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Post", res["resource"])
    assert_equal("Not found", res["message"])
  end

  test "delete post" do
    delete post_url(@post.id), params: delete_post_payload
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("Test", res["title"])
    assert_equal("This is a test description", res["description"])
    assert_equal("This is a test content", res["content"])
    assert_equal(false, res["published"])
  end

  test "delete post with different author" do
    params = delete_post_payload
    params[:author_id] = @post.author_id + 10

    delete post_url(@post.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("author", res["errors"][0]["field"])
    assert_equal("not authorized for this action", res["errors"][0]["message"])
  end

  test "delete post by not found id" do
    delete post_url("not-found"), params: delete_post_payload
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Post", res["resource"])
    assert_equal("Not found", res["message"])
  end

  test "get comments by id" do
    get comments_post_url(@post.id)
    assert_response :ok

    res = JSON.parse(@response.body)

    assert_equal(Array, res.class)
    assert_equal(1, res.size)
    assert_equal("This is a test", res[0]["content"])
    assert_equal(10, res[0]["reaction_summary"]["likes"])
  end

  test "get comments by not found id" do
    get comments_post_url("not-found")
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Post", res["resource"])
    assert_equal("Not found", res["message"])
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

  def update_post_payload
    {
      title: "Test",
      content: "This is a test content",
      description: "This is a test description",
      author_id: @post.author_id,
      published: true
    }
  end

  def delete_post_payload
    {
      author_id: @post.author_id
    }
  end
end
