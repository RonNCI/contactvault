class ContactsController < ApplicationController
  before_action :require_login
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # displays all contacts for the current user, sorted by name
  def index
    @contacts = current_user.contacts.order(name: :asc)
  end

  # shows a single contact
  def show
  end

  # initializes a new contact for the form
  def new
    @contact = current_user.contacts.build
  end

  # creates a new contact with the provided parameters
  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: 'Contact successfully added to vault!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # displays the edit form for a contact
  def edit
  end

  # updates an existing contact with the provided parameters
  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'Contact updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # removes a contact from the database
  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: 'Contact removed from vault.'
  end

  private

  # whitelists allowed parameters for contact creation and updates
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :address)
  end

  # finds the contact for the current user based on the id parameter
  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end
end