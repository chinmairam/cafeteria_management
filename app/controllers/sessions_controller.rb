class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to menus_path
    end
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)
    if user_authenticate(password)
      session[:current_user_id] = user.id
      redirect_to menus_path
    else
      render plain: "Incorrect Credentials"
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to menus_path
  end
end
