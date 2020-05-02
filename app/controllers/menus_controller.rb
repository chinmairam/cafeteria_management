class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def index
  end

  def create
    name = params[:name]
    Menu.create!(
      name: name,
    )
    redirect_to menus_path
  end

  def destroy
  ensure_owner_logged_in
    id = params[:id]
    menu = Menu.find(id)
    menu_items = MenuItem.allwhere("menu_id=?", id)
    menu_items.map { |menu_item| menu_item.destroy }
    menu.destroy
    redirect_to menus_path
  end
end
