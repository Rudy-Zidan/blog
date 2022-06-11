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
