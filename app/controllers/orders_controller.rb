class OrdersController < ApplicationController
  def index
    orders = current_user.orders.order(:id)
  end

  def pending_orders
    ensure_owner_or_clerk_logged_in
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    if @user.id == current_user.id
    else
      ensure_owner_logged_in
    end
  end

  def create
    order = current_user.orders.being_created.first
    if order.order_items.empty?
      redirect_to(cart_path, alert: "Order should have atleast 1 fooditem")
    else
      order.status = "order_confirmed"
      order.address = params[:address]
      order.ordered_at = DateTime.now
      if order.save
        flash[:notice] = "Order recived! Soon your order will be delivered"
        redirect_to orders_path
      else
        flash[:error] = order.errors.full_messages
        redirect_to cart_path
      end
    end
  end

  def sale
    ensure_owner_logged_in
    @user = User.all
    @orders = Order.completed
    @menus = Menu.all
    @menu_items = MenuItem.all
  end

  def update
    ensure_owner_or_clerk_logged_in
    order = Order.find(params[:id])
    order.status = "Order_delivered"
    order.delivered_at = Time.now + 19800
    order.date = Date.today
    order.save!
    flash[:notice] = "#{@order.id} is marked as delivered!"
    redirect_to "/pending_orders"
  end

  def cart
    @order = current_user.orders.being_created
  end

  def all_orders
    ensure_owner_logged_in
    @all_orders = Order.order(id: :desc)
  end

  def destroy
    order = Order.find(params[:id])
    if order.user_id == current_user.id
      order.destroy
      flash[:notice] = "Order deleted"
    else
      flash[:alert] = "You are not permitted"
    end
    redirect_to request.referer
  end

  def rating
    order = Order.find(params[:id])
    order.ratings = params[:rating]
    order.save!
    order.order_items.rate_menu_items(params[:rating])
    flash[:notice] = "Thanks for rating"
    redirect_to request.referer
  end
end
