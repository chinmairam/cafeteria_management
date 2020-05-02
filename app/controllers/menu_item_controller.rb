class MenuItemsController < ApllicationController
  skip_before_action :verify_authenticity_token

  def index
    @menu_id = params[:menu_id]
    @menu_items = MenuItem.return(@menu_id)
    @menu_name = Menu.find(@menu_id).menu_name
  end

  def create
    MenuItem.create!(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      menu_id: params[:menu_id],
    )
    redirect_to menu_items_path(menu_id: params[:menu_id])
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.find(id)
    menu_item.destroy
    redirect_to menu_items_path(menu_id: params[:menu_id])
  end
end
