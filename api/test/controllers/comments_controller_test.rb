require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:one)
    @comment_reaction = comment_reactions(:one)
  end

  test "create comment" do
    post comments_url, params: create_comment_payload
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("This is a test", res["content"])
    assert_equal("John", res["user"]["name"])
  end

  test "create comment with a non existing author" do
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

  test "update comment" do
    put comment_url(@comment.id), params: update_comment_payload
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("This is a test update", res["content"])
    assert_equal("John", res["user"]["name"])
  end

  test "update comment with blank payload" do
    params = update_comment_payload
    params[:content] = ""

    put comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("content", res["errors"][0]["field"])
    assert_equal("can't be blank", res["errors"][0]["message"])
  end

  test "update comment with different user" do
    params = update_comment_payload
    params[:user_id] += 10

    put comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("comment", res["errors"][0]["field"])
    assert_equal("the original post or the user are not allowed to be changed", res["errors"][0]["message"])
  end

  test "delete comment" do
    delete comment_url(@comment.id), params: delete_comment_payload
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("This is a test", res["content"])
  end

  test "delete comment with different user" do
    params = delete_comment_payload
    params[:user_id] += 10

    delete comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("user", res["errors"][0]["field"])
    assert_equal("not authorized for this action", res["errors"][0]["message"])
  end

  test "delete comment by not found id" do
    delete comment_url("not-found"), params: delete_comment_payload
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("Comment", res["resource"])
    assert_equal("Not found", res["message"])
  end

  test "create comment_reaction" do
    post reactions_comment_url(@comment.id), params: create_comment_reaction_payload
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("like", res["reaction"])
  end

  test "create comment_reaction with invalid reaction" do
    params = create_comment_reaction_payload
    params[:reaction] = ""

    post reactions_comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("reaction", res["errors"][0]["field"])
    assert_equal("invalid reaction, should be (like or smile or thumbs_up)", res["errors"][0]["message"])
  end

  test "create comment_reaction with invalid user" do
    params = create_comment_reaction_payload
    params[:user_id] = nil

    post reactions_comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("user", res["errors"][0]["field"])
    assert_equal("must exist", res["errors"][0]["message"])
  end

  test "create comment_reaction with duplicate reaction" do
    params = create_comment_reaction_payload
    params[:user_id] = users(:one).id

    post reactions_comment_url(@comment.id), params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("type", res["errors"][0]["field"])
    assert_equal("you already reacted in the same way before", res["errors"][0]["message"])
  end

  test "delete comment_reaction" do
    delete "#{reactions_comment_url(@comment_reaction.comment_id)}/#{@comment_reaction.id}", params: delete_comment_reaction_payload
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal("like", res["reaction"])
  end

  test "delete comment_reaction with different user" do
    params = delete_comment_reaction_payload
    params[:user_id] += 10

    delete "#{reactions_comment_url(@comment_reaction.comment_id)}/#{@comment_reaction.id}", params: params
    assert_response :bad_request

    res = JSON.parse(@response.body)
    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)
    assert_equal("user", res["errors"][0]["field"])
    assert_equal("not authorized for this action", res["errors"][0]["message"])
  end

  private

  def create_comment_payload
    {
      post_id: posts(:one).id,
      user_id: users(:one).id,
      content: "This is a test"
    }
  end

  def update_comment_payload
    {
      post_id: @comment.post_id,
      user_id: @comment.user_id,
      content: "This is a test update"
    }
  end

  def delete_comment_payload
    {
      user_id: @comment.user_id
    }
  end

  def create_comment_reaction_payload
    {
      user_id: users(:two).id,
      reaction: "like"
    }
  end

  def delete_comment_reaction_payload
    {
      user_id: @comment.user_id
    }
  end
end
