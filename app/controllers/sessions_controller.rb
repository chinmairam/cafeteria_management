class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if current_user
      redirect_to(menus_path, notice: "You are alreday signed in user")
    end
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      session[:current_user_id] = user.id
      flash[:notice] = "You are signed in successfully"
      redirect_to root_path
    elsif user
      flash[:alert] = "Incorrect Password"
      redirect_to new_session_path
    else
      flash[:alert] = "No Account with given email"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:notice] = "You are logged out successfully!"
    redirect_to root_path
  end
end
