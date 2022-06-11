require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create user" do
    post users_url, params: new_user_params
    assert_response :created

    res = JSON.parse(@response.body)
    assert_equal("Test", res["name"])
    assert_equal("test@example.com", res["email"])
  end

  private

  def new_user_params
    {
      name: "Test", 
      email: "test@example.com"
    }
  end
end
