require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    
    # Create test contacts
    @contact = Contact.create(
      name: "John Doe",
      email: "john@example.com",
      user: @user
    )
    
    # Create test activities
    @activity = Activity.create(
      user: @user,
      action: "added",
      subject: "John Doe"
    )
  end

  test "should get dashboard when logged in" do
    login_as(@user)
    get dashboard_path
    assert_response :success
    assert_template 'dashboard/index'
  end

  test "should redirect to login when not authenticated" do
    get dashboard_path
    assert_redirected_to login_path
  end

  test "should display user's contacts count" do
    login_as(@user)
    get dashboard_path
    assert_select '.contact-count', text: '1'
  end

  test "should display recent activities" do
    login_as(@user)
    get dashboard_path
    assert_select '.activity-list' do
      assert_select '.activity-item', count: 1
      assert_select '.activity-item', text: /John Doe/
    end
  end
end