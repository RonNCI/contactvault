require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  def setup
    # create a test user
    @user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    # log in as the test user
    login_as(@user)
  end

  test "visiting the contacts index" do
    # visit the contacts index page
    visit contacts_path
    # verify page elements
    assert_selector "h1", text: "Contacts"
    assert_selector "a", text: "New Contact"
  end

  test "creating a new contact" do
    # visit the new contact form
    visit new_contact_path
    
    # fill in the contact details
    fill_in "Name", with: "Jane Smith"
    fill_in "Email", with: "jane@example.com"
    fill_in "Phone", with: "987-654-3210"
    fill_in "Address", with: "456 Oak St"
    
    # submit the form
    click_button "Create Contact"
    
    # verify success message and redirect
    assert_text "Contact was successfully created"
    assert_current_path contacts_path
  end

  test "updating a contact" do
    # create a test contact
    contact = Contact.create!(
      name: "John Doe",
      email: "john@example.com",
      user: @user
    )
    
    # visit the edit contact form
    visit edit_contact_path(contact)
    
    # update the contact name
    fill_in "Name", with: "John Updated"
    click_button "Update Contact"
    
    # verify success message and updated name
    assert_text "Contact was successfully updated"
    assert_text "John Updated"
  end

  test "deleting a contact" do
    # create a test contact
    contact = Contact.create!(
      name: "John Doe",
      email: "john@example.com",
      user: @user
    )
    
    # visit the contacts index
    visit contacts_path
    # confirm and delete the contact
    accept_confirm do
      click_on "Delete", match: :first
    end
    
    # verify success message and removal
    assert_text "Contact was successfully deleted"
    assert_no_text contact.name
  end
end