class RegistrationsController < ApplicationController
  # redirects to root if already logged in, otherwise shows signup form
  def new
    redirect_to root_path, notice: "You're already logged in!" if logged_in?
    @vault_user = User.new
  end

  # creates a new user account
  def create
    @vault_user = User.new(vault_user_params)
    
    if @vault_user.save
      session[:user_id] = @vault_user.id
      redirect_to root_path, notice: "Welcome to Contactvault! Your account has been created successfully."
    else
      flash.now[:alert] = "Please correct the errors below"
      render :new, status: :unprocessable_entity
    end
  end

  private

  # whitelist parameters and strip whitespace
  def vault_user_params
    params.require(:vault_user)
          .permit(:email, :password, :password_confirmation)
          .transform_values(&:strip)
  end
end