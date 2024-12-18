class SessionsController < ApplicationController
  # displays the login form
  def new
  end

  # handles the login form submission
  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Welcome to Contactvault!'
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new, status: :unprocessable_entity
    end
  end

  # handles user logout
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Successfully logged out'
  end
end