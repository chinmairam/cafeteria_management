class MenuItemsController < ApllicationController
  def index
  end

  def show
  end

  def create
    menu = Menu.where(name: params[:menu_name].capitalize).exists? ? Menu.where(name: params[:menu_name].capitalize).first : Menu.new(name: params[:menu_name].capitalize)
    menu.save
    menu_item = MenuItem.new(name: params[:name].capitalize, description: params[:description].capitalize, menu_id: menu.id, price: params[:price])
    if menu.save && menu_item.save
      redirect_to menus_path
    else
      redirect_to menus_path
    end
  end

  def destroy
    ensure_owner_logged_in
    MenuItem.find(params[:id]).destroy
    redirect_to menus_path
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    menu = Menu.where(name: params[:menu_name].capitalize).exists? ? Menu.where(name: params[:menu_name].capitalize).first : Menu.new(name: params[:menu_name].capitalize)
    menu.save
    menu_item = MenuItem.find(params[:id])
    menu_item.update(name: params[:name].capitalize, description: params[:description].capitalize, menu_id: menu.id, price: params[:price])
    if menu.save && menu_item.save
      redirect_to menus_path
    end
  end
end
