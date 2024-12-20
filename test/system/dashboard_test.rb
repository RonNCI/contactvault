require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    
    # Create sample data
    3.times do |i|
      Contact.create(
        name: "Contact #{i}",
        email: "contact#{i}@example.com",
        user: @user
      )
    end
    
    login_as(@user)
  end

  test "visiting the dashboard" do
    visit dashboard_path
    
    assert_selector "h1", text: "Dashboard"
    assert_selector ".contact-count", text: "3"
    assert_selector ".recent-activities"
    assert_selector ".quick-actions"
  end

  test "navigating to contacts from dashboard" do
    visit dashboard_path
    click_on "View All Contacts"
    assert_current_path contacts_path
  end

  test "creating new contact from dashboard" do
    visit dashboard_path
    click_on "Add New Contact"
    assert_current_path new_contact_path
  end

  test "displaying recent activities" do
    Activity.create(
      user: @user,
      action: "added",
      subject: "New Contact"
    )
    
    visit dashboard_path
    within ".recent-activities" do
      assert_text "added"
      assert_text "New Contact"
    end
  end
end
