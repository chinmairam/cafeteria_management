class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:create, :new]

  def new
    if current_user
      flash[:notice] = "You are already signed up user"
      redirect_to menus_path
    else
      render "users/new"
    end
  end

  def show
    unless current_user
      redirect_to root_path
    end
  end

  def index
    ensure_owner_logged_in
    @clerks = User.clerks.order(:id)
    @customers = User.customers.order(:id)
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    user = User.new(name: name.capitalize, email: email, role: "customer", password: password)
    if user.save
      user.save!
      session[:current_user_id] = user.id
      redirect_to new_session_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def edit
    unless current_user
      redirect_to root_path
    end
  end

  def clerk
    ensure_owner_logged_in
    name = params[:name]
    email = params[:email]
    password = params[:password]
    user = User.new(name: name.capitalize, email: email, role: "clerk", password: password)
    if user.save
      user.save!
      session[:current_user_id] = user.id
      redirect_to request.referer
    else
      flash[:error] = user.errors.full_messages
      redirect_to request.referer
    end
  end

  def clerk_update
    ensure_owner_logged_in
    id = params[:id]
    user = User.find(id)
    if user.is_clerk?
      user.destroy
    else
      flash[:alert] = "Role can't be changed"
    end
    redirect_to request.referer
  end
end
