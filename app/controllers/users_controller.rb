class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def create
    new_user = User.new(
      id: params[:id],
      name: params[:name],
      role: params[:role],
    )
    if new_user.save
      redirect_to new_sessions_path
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
