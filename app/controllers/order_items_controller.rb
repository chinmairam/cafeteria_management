class OrderItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: OrderItem.all.map { |order| order.to_a_string }.join("\n")
  end

  def show
    render plain: OrderItem.find(params[:id]).to_a_string
  end

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    order = current_user.orders.under_process ? current_user.orders.under_process : Order.create!(user_id: current_user.id)
    order_item = OrderItem.create!(order_id: order.id,
                                   menu_item_id: menu_item.id,
                                   menu_item_name: menu_item.name,
                                   menu_item_price: menu_item.price)
    if params[:cart]
      redirect_to cart_path
      flash[:notice] = "Item added successfully"
    else
      redirect_to menus_path
      flash[:error] = menu_item.errors.full_messages + menu.errors.full_messages
    end
  end

  def destroy
    order_item_id = params[:id]
    order_item = OrderItem.find(order_item_id).destroy
    if params[:cart]
      redirect_to cart_path
      flash[:notice] = "Item updated successfully!"
      flash[:error] = menu_item.errors.full_messages + menu.errors.full_messages
    else
      flash[:error] = menu_item.errors.full_messages + menu.errors.full_messages
      redirect_to menus_path
    end
  end
end
