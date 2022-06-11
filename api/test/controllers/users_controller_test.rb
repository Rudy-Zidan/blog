require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create user" do
    post users_url, params: new_user_params
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("Test", res["name"])
    assert_equal("test@example.com", res["email"])
  end

  test "duplicate user request" do
    post users_url, params: duplicate_user_params
    assert_response :bad_request

    res = JSON.parse(@response.body)

    assert_equal(%w(errors), res.keys)
    assert_equal(1, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)

    assert_equal("email", res["errors"][0]["field"])
    assert_equal("has already been taken", res["errors"][0]["message"])
  end

  test "missing required user info request" do
    post users_url, params: {}
    assert_response :bad_request

    res = JSON.parse(@response.body)

    assert_equal(%w(errors), res.keys)
    assert_equal(2, res["errors"].size)
    assert_equal(%w(field message), res["errors"][0].keys)

    assert_equal("name", res["errors"][0]["field"])
    assert_equal("can't be blank", res["errors"][0]["message"])

    assert_equal("email", res["errors"][1]["field"])
    assert_equal("can't be blank", res["errors"][1]["message"])
  end

  test "get posts by author" do
    user = users(:one)
    get posts_user_url(user.id)
    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal(1, res.size)
    assert_equal("Test", res[0]["title"])
    assert_equal("This is a test description", res[0]["description"])
    assert_equal("This is a test content", res[0]["content"])
  end

  test "get posts by not found author" do
    get posts_user_url("not-found")
    assert_response :not_found

    res = JSON.parse(@response.body)
    assert_equal("User", res["resource"])
    assert_equal("Not found", res["message"])
  end

  private

  def new_user_params
    {
      name: "Test", 
      email: "test@example.com"
    }
  end

  def duplicate_user_params
    {
      name: "John", 
      email: "john@example.com"
    }
  end
end
