class OrdersController < ApplicationController
  def index
    orders = current_user.orders.order(:id)
  end

  def pending_orders
    ensure_owner_or_clerk_logged_in
  end

  def show
    ensure_owner_logged_in
    if @current_user
    end
  end

  def create
    @order = current_user.orders.being_created
    if @order.order_items.empty?
      redirect_to(cart_path, alert: "Order should have atleast 1 fooditem")
    else
      @order.status = "order_confirmed"
      @order.date = Time.now + 20000
      @order.save!
      flash[:notice] = "Order recived! Soon your order will be delivered"
      redirect_to orders_path
    end
  end

  def update
    ensure_owner_or_clerk_logged_in
    @order = Order.find(params[:id])
    @order.status = "Order_Delivered"
    @order.delivered_at = Time.now + 20000
    @order.save!
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
    if order.user_id == @current_user.id
      order.destroy
    else
      flash[:alert] = "You are not permitted"
    end
    redirect_to orders_path
  end

  def rating
    @order = Order.find(params[:id])
    @order.ratings = params[:rating]
    @order.save!
    @order.order_items.rate_menu_items(params[:rating])
    redirect_to(orders_path, notice: "Thanks for rating order ")
  end
end
