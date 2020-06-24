class MenuItemsController < ApplicationController
  def index
  end

  def show
  end

  def create
    if params[:id]
      menu = params[:id] == "Add a Menu" ? Menu.new(name: params[:new_menu_name]) : Menu.find(params[:id])
      menu.save
      menu_item = MenuItem.new(name: params[:name].capitalize, description: params[:description].capitalize, menu_id: menu.id, price: params[:price])
      if menu.save && menu_item.save
        flash[:notice] = "Item added successfully!"
      else
        flash[:error] = menu_item.errors.full_messages + menu.errors.full_messages
      end
    else
      flash[:alert] = "Select a Menu Name"
    end
    redirect_to menus_path
  end

  def edit
    ensure_owner_logged_in
    @menu_item = MenuItem.find(params[:id])
  end

  def destroy
    ensure_owner_logged_in
    menu_item = MenuItem.find(params[:id])
    menu = Menu.find(menu_item.menu_id)
    if menu.menu_items.count == 1
      menu.destroy
    end
    menu_item.destroy
    flash[:alert] = "Item Deleted"
    redirect_to menus_path
  end

  def update
    menu_item = MenuItem.find(params[:id])
    menu_item.name = params[:name].capitalize
    menu_item.description = params[:description].capitalize
    menu_item.price = params[:price]
    if menu_item.save
      flash[:notice] = "Item updated successfully!"
      redirect_to menus_path
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to edit_menu_item_path
    end
  end

  private

  def permit_params
    params.require(:menu_item).pemit(:name, :description, :menu_name, :price)
  end
end
