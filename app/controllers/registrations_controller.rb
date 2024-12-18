class RegistrationsController < ApplicationController
  # displays the signup form
  def new
    @vault_user = User.new
  end

  # handles the signup form submission
  def create
    @vault_user = User.new(user_params)
    
    if @vault_user.save
      session[:user_id] = @vault_user.id
      redirect_to dashboard_path, notice: 'Welcome to Contactvault!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # defines allowed parameters for user registration
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end