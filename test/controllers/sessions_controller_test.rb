require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # create a test user
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  # test the login page is accessible
  test "should get login page" do
    get login_path
    assert_response :success
    assert_template 'sessions/new'
  end

  # test redirect if user is already logged in
  test "should redirect to dashboard if already logged in" do
    login_as(@user)
    get login_path
    assert_redirected_to dashboard_path
  end

  # test successful login with correct credentials
  test "should login with valid credentials" do
    post login_path, params: { 
      session: { 
        email: @user.email, 
        password: "password123" 
      } 
    }
    assert_redirected_to dashboard_path
    assert_equal "Successfully logged in!", flash[:notice]
    assert session[:user_id]
  end

  # test failed login with incorrect credentials
  test "should not login with invalid credentials" do
    post login_path, params: { 
      session: { 
        email: @user.email, 
        password: "wrongpassword" 
      } 
    }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_equal "Invalid email or password", flash[:alert]
    assert_nil session[:user_id]
  end

  # test successful logout
  test "should logout successfully" do
    login_as(@user)
    delete logout_path
    assert_redirected_to login_path
    assert_equal "Successfully logged out!", flash[:notice]
    assert_nil session[:user_id]
  end
end