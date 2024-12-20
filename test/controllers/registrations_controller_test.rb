require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  # test registration page access
  test "should get registration page" do
    get new_vault_user_path
    assert_response :success
    assert_template 'registrations/new'
  end
    # test successful user creation with valid data
    test "should create new user with valid data" do
      assert_difference('User.count') do
        post register_path, params: { 
          user: { 
            email: "newuser@example.com",
            password: "password123",
            password_confirmation: "password123"
          } 
        }
      end
      assert_redirected_to dashboard_path
      assert_equal "Welcome to Contactvault!", flash[:notice]
      assert session[:user_id]
    end
  # test failed user creation with invalid data
  test "should not create user with invalid data" do
    assert_no_difference('User.count') do
      post register_path, params: { 
        user: { 
          email: "invalid-email",
          password: "short",
          password_confirmation: "nomatch"
        } 
      }
    end
    assert_response :unprocessable_entity
    assert_template 'registrations/new'
  end

  # test failed user creation with duplicate email
  test "should not create user with duplicate email" do
    existing_user = User.create(
      email: "existing@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert_no_difference('User.count') do
      post register_path, params: { 
        user: { 
          email: "existing@example.com",
          password: "newpassword123",
          password_confirmation: "newpassword123"
        } 
      }
    end
    assert_response :unprocessable_entity
    assert_template 'registrations/new'
  end
end