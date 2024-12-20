require "test_helper"
# tests for the User model
class UserTest < ActiveSupport::TestCase
  # tests that a user with valid attributes is valid
  test "user with valid attributes" do
    user = User.new(email: "test@example.com", password: "secure123")
    assert user.valid?
  end

  # tests that a user requires an email
  test "user requires email" do
    user = User.new(password: "secure123")
    assert_not user.valid?
    assert_includes user.errors[:email], "Email cannot be blank"
  end

  # tests that a user password meets minimum length requirement
  test "user requires minimum password length" do
    user = User.new(email: "test@example.com", password: "short")
    assert_not user.valid?
    assert_includes user.errors[:password], "Password must be at least 6 characters long"
  end
end