require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "successful registration flow" do
    get "/register"
    assert_response :success

    assert_difference "User.count" do
      post "/register", params: {
        user: {
          email: "newuser@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to login_path
    assert_equal "Account created successfully!", flash[:notice]
  end

  test "successful login flow" do
    # Create test user
    user = User.create!(
      email: "test@example.com",
      password: "password123"
    )

    # Attempt login
    get "/login"
    assert_response :success

    post "/login", params: {
      user: {
        email: user.email,
        password: "password123"
      }
    }

    assert_redirected_to contacts_path
    assert_equal user.id, session[:user_id]
  end

  test "failed login with invalid credentials" do
    post "/login", params: {
      user: {
        email: "wrong@example.com",
        password: "wrongpass"
      }
    }

    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "failed registration with invalid data" do
    assert_no_difference "User.count" do
      post "/register", params: {
        user: {
          email: "",
          password: "short",
          password_confirmation: "nomatch"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
