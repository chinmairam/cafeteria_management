class MenusController < ApplicationController
  def new
  end

  def index
    @menus = Menu.order(:name)
    @order = current_user.orders.being_created
  end

  def create
    menu = Menu.create!(name: params[:name].capitalize)
    render plain: "created #{menu.name} with #{menu.id}"
    redirect_to menus_path
  end

  def destroy
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to menus_path
  end
end
