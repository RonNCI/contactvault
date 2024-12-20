require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "visiting the login page" do
    visit login_path
    
    assert_selector "h2", text: "Login to Vault"
    assert_selector "label", text: "Email"
    assert_selector "label", text: "Password"
    assert_selector "input[type=submit][value=Login]"
    assert_link "Create new account"
  end

  test "logging in with valid credentials" do
    visit login_path
    
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password123"
    click_button "Login"

    assert_current_path dashboard_path
    assert_text "Successfully logged in!"
  end

  test "displaying error with invalid credentials" do
    visit login_path
    
    fill_in "Email", with: @user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Login"

    assert_text "Invalid email or password"
    assert_current_path login_path
  end
end
