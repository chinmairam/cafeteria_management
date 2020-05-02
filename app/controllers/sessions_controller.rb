class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if current_user
      flash[:notice] = "Your are already signed in"
      redirect_to menus_path
    end
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)
    if user && user_authenticate(password)
      session[:current_user_id] = user.id
      flash[:notice] = "You are signed in successfully!"
      redirect_to menus_path
    elsif user
      flash[:alert] = "Your password is incorrect"
      redirect_to new_session_path
    else
      flash[:alert] = "No account with given email"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:notice] = "Your'e logged Out successfully!"
    redirect_to root_path
  end
end
