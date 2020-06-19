class MenusController < ApplicationController
  def index
    @menus = Menu.order(:name)
    @order = current_user.orders.being_created
  end

  def show
    @id = params[:id]
    menu = Menu.find(@id)
    @name = menu.name
    @menu_items = menu.menu_items.order(:id)
    render "show"
  end

  def create
    menu = Menu.create!(name: params[:name].capitalize)
    flash[:notice] = "Menu added!"
  end

  def destroy
    ensure_owner_logged_in
    @menu = Menu.find(params[:id])
    @menu.destroy!
    flash[:alert] = "Menu Deleted"
    redirect_to menus_path
  end
end
