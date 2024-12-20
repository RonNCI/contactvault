require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  # setup test data
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    @contact = Contact.create(
      name: "John Doe",
      email: "john@example.com",
      phone: "123-456-7890",
      address: "123 Main St",
      user: @user
    )
  end

  # test index page access for logged in users
  test "should get index when logged in" do
    login_as(@user)
    get contacts_path
    assert_response :success
    assert_template 'contacts/index'
  end

  # test redirect for unauthenticated users
  test "should redirect to login when not authenticated" do
    get contacts_path
    assert_redirected_to login_path
  end

  # test new contact form display
  test "should get new contact form" do
    login_as(@user)
    get new_contact_path
    assert_response :success
    assert_template 'contacts/new'
  end

  # test successful contact creation
  test "should create contact with valid data" do
    login_as(@user)
    assert_difference('Contact.count') do
      post contacts_path, params: {
        contact: {
          name: "Jane Smith",
          email: "jane@example.com",
          phone: "987-654-3210",
          address: "456 Oak St",
          user_id: @user.id
        }
      }
    end
    assert_redirected_to contacts_path
    assert_equal "Contact successfully added to vault!", flash[:notice]
  end

  # test failed contact creation
  test "should not create contact with invalid data" do
    login_as(@user)
    assert_no_difference('Contact.count') do
      post contacts_path, params: {
        contact: {
          name: "",
          email: "invalid-email",
          phone: "invalid-phone",
          user_id: @user.id
        }
      }
    end
    assert_response :unprocessable_entity
    assert_template 'contacts/new'
  end

  # test contact details display
  test "should show contact" do
    login_as(@user)
    get contact_path(@contact)
    assert_response :success
    assert_template 'contacts/show'
  end

  # test edit form display
  test "should get edit form" do
    login_as(@user)
    get edit_contact_path(@contact)
    assert_response :success
    assert_template 'contacts/edit'
  end

  # test contact update functionality
  test "should update contact" do
    login_as(@user)
    patch contact_path(@contact), params: {
      contact: {
        name: "John Updated",
        email: "john.updated@example.com"
      }
    }
    assert_redirected_to contact_path(@contact)
    assert_equal "Contact updated successfully!", flash[:notice]
  end

  # test contact deletion
  test "should delete contact" do
    login_as(@user)
    assert_difference('Contact.count', -1) do
      delete contact_path(@contact)
    end
    assert_redirected_to contacts_path
    assert_equal "Contact removed from vault.", flash[:notice]
  end
end