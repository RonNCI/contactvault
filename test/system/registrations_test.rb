require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  # test visiting the registration page
  test "visiting the registration page" do
    visit new_vault_user_path
    
    assert_selector "h2", text: "Create Account"
    assert_selector "label", text: "Email"
    assert_selector "label", text: "Password"
    assert_selector "label", text: "Password confirmation"
    assert_selector "input[type=submit][value='Create Account']"
  end

  # test creating a new account with valid information
  test "creating a new account with valid information" do
    visit new_vault_user_path
    
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Create Account"

    assert_current_path dashboard_path
    assert_text "Account created successfully!"
  end

  # test showing validation errors with invalid information
  test "showing validation errors with invalid information" do
    visit new_vault_user_path
    
    fill_in "Email", with: "invalid-email"
    fill_in "Password", with: "short"
    fill_in "Password confirmation", with: "nomatch"
    click_button "Create Account"

    assert_text "Email is invalid"
    assert_text "Password is too short"
    assert_text "Password confirmation doesn't match Password"
  end
end